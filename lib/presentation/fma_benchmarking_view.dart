import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaBenchmarkingView extends StatefulWidget {
  const FmaBenchmarkingView({super.key});

  @override
  State<FmaBenchmarkingView> createState() => _FmaBenchmarkingViewState();
}

class _FmaBenchmarkingViewState extends State<FmaBenchmarkingView> {
  int currentTab = 0;
  String selectedCategory = "";
  String selectedPeriod = "monthly";
  String selectedBenchmarkType = "";
  
  List<Map<String, dynamic>> benchmarkData = [
    {
      "category": "Revenue Performance",
      "metric": "Monthly Revenue",
      "ourValue": 125000.0,
      "industryAverage": 98000.0,
      "topPerformer": 156000.0,
      "unit": "\$",
      "performance": "above",
      "percentile": 75,
      "improvement": 12.5,
      "trend": "improving"
    },
    {
      "category": "Customer Satisfaction",
      "metric": "Customer Rating",
      "ourValue": 4.6,
      "industryAverage": 4.2,
      "topPerformer": 4.9,
      "unit": "★",
      "performance": "above",
      "percentile": 68,
      "improvement": 0.3,
      "trend": "stable"
    },
    {
      "category": "Operational Efficiency",
      "metric": "Service Speed",
      "ourValue": 3.2,
      "industryAverage": 4.1,
      "topPerformer": 2.8,
      "unit": " min",
      "performance": "below",
      "percentile": 45,
      "improvement": -0.8,
      "trend": "declining"
    },
    {
      "category": "Employee Productivity",
      "metric": "Sales per Employee",
      "ourValue": 8750.0,
      "industryAverage": 7500.0,
      "topPerformer": 12000.0,
      "unit": "\$",
      "performance": "above",
      "percentile": 72,
      "improvement": 16.7,
      "trend": "improving"
    },
    {
      "category": "Cost Management",
      "metric": "Operating Cost Ratio",
      "ourValue": 0.68,
      "industryAverage": 0.72,
      "topPerformer": 0.58,
      "unit": "",
      "performance": "above",
      "percentile": 65,
      "improvement": -5.6,
      "trend": "improving"
    },
    {
      "category": "Market Share",
      "metric": "Local Market Share",
      "ourValue": 24.5,
      "industryAverage": 18.2,
      "topPerformer": 35.8,
      "unit": "%",
      "performance": "above",
      "percentile": 78,
      "improvement": 3.2,
      "trend": "improving"
    }
  ];

  List<Map<String, dynamic>> competitorData = [
    {
      "name": "Competitor A",
      "revenue": 142000.0,
      "customerSatisfaction": 4.3,
      "efficiency": 89,
      "marketShare": 28.5,
      "strength": "Revenue Leadership",
      "weakness": "Customer Service"
    },
    {
      "name": "Competitor B", 
      "revenue": 118000.0,
      "customerSatisfaction": 4.7,
      "efficiency": 92,
      "marketShare": 22.1,
      "strength": "Customer Experience",
      "weakness": "Market Penetration"
    },
    {
      "name": "Competitor C",
      "revenue": 89000.0,
      "customerSatisfaction": 4.1,
      "efficiency": 85,
      "marketShare": 15.8,
      "strength": "Cost Efficiency",
      "weakness": "Service Quality"
    },
    {
      "name": "Industry Average",
      "revenue": 98000.0,
      "customerSatisfaction": 4.2,
      "efficiency": 82,
      "marketShare": 18.2,
      "strength": "Baseline",
      "weakness": "N/A"
    }
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": ""},
    {"label": "Revenue Performance", "value": "Revenue Performance"},
    {"label": "Customer Satisfaction", "value": "Customer Satisfaction"},
    {"label": "Operational Efficiency", "value": "Operational Efficiency"},
    {"label": "Employee Productivity", "value": "Employee Productivity"},
    {"label": "Cost Management", "value": "Cost Management"},
    {"label": "Market Share", "value": "Market Share"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> benchmarkTypeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Industry Benchmark", "value": "industry"},
    {"label": "Competitor Benchmark", "value": "competitor"},
    {"label": "Historical Benchmark", "value": "historical"},
  ];

  List<Map<String, dynamic>> get filteredBenchmarks {
    return benchmarkData.where((benchmark) {
      bool matchesCategory = selectedCategory.isEmpty || benchmark["category"] == selectedCategory;
      return matchesCategory;
    }).toList();
  }

  Color _getPerformanceColor(String performance) {
    switch (performance) {
      case "above":
        return successColor;
      case "below":
        return dangerColor;
      case "equal":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "improving":
        return successColor;
      case "declining":
        return dangerColor;
      case "stable":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Benchmarking Analysis",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Metrics", icon: Icon(Icons.bar_chart)),
        Tab(text: "Competitors", icon: Icon(Icons.business)),
        Tab(text: "Insights", icon: Icon(Icons.insights)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildMetricsTab(),
        _buildCompetitorsTab(),
        _buildInsightsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    int aboveAverage = benchmarkData.where((b) => b["performance"] == "above").length;
    int belowAverage = benchmarkData.where((b) => b["performance"] == "below").length;
    double avgPercentile = benchmarkData.fold(0.0, (sum, b) => sum + (b["percentile"] as int)) / benchmarkData.length;
    int improving = benchmarkData.where((b) => b["trend"] == "improving").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildOverviewCard(
                "Above Average",
                "$aboveAverage/${benchmarkData.length}",
                Icons.trending_up,
                successColor,
              ),
              _buildOverviewCard(
                "Below Average",
                "$belowAverage/${benchmarkData.length}",
                Icons.trending_down,
                dangerColor,
              ),
              _buildOverviewCard(
                "Avg Percentile",
                "${avgPercentile.toStringAsFixed(0)}th",
                Icons.analytics,
                primaryColor,
              ),
              _buildOverviewCard(
                "Improving Metrics",
                "$improving/${benchmarkData.length}",
                Icons.north_east,
                warningColor,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Performance Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: benchmarkData.take(4).map((benchmark) {
                    Color performanceColor = _getPerformanceColor(benchmark["performance"]);
                    String performanceText = benchmark["performance"] == "above" 
                        ? "Above Industry Average" 
                        : benchmark["performance"] == "below" 
                            ? "Below Industry Average" 
                            : "At Industry Average";
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: performanceColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: performanceColor.withAlpha(30),
                          width: 1,
                        ),
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
                                  "${benchmark["metric"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${benchmark["category"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${benchmark["ourValue"]}${benchmark["unit"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: performanceColor,
                                  ),
                                ),
                                Text(
                                  performanceText,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: performanceColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Top Performers vs Industry Average",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: benchmarkData.take(4).map((benchmark) {
                      double ourValue = benchmark["ourValue"] as double;
                      double industryAverage = benchmark["industryAverage"] as double;
                      double topPerformer = benchmark["topPerformer"] as double;
                      
                      double maxValue = [ourValue, industryAverage, topPerformer].reduce((a, b) => a > b ? a : b);
                      
                      double ourHeight = (ourValue / maxValue) * 120;
                      double industryHeight = (industryAverage / maxValue) * 120;
                      double topHeight = (topPerformer / maxValue) * 120;
                      
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${benchmark["metric"].toString().split(' ')[0]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: ourHeight,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              SizedBox(width: 2),
                              Container(
                                width: 12,
                                height: industryHeight,
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              SizedBox(width: 2),
                              Container(
                                width: 12,
                                height: topHeight,
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem("Our Performance", primaryColor),
                    SizedBox(width: spMd),
                    _buildLegendItem("Industry Average", warningColor),
                    SizedBox(width: spMd),
                    _buildLegendItem("Top Performer", successColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodOptions,
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
                  label: "Benchmark Type",
                  items: benchmarkTypeOptions,
                  value: selectedBenchmarkType,
                  onChanged: (value, label) {
                    selectedBenchmarkType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: filteredBenchmarks.length,
            itemBuilder: (context, index) {
              final benchmark = filteredBenchmarks[index];
              Color performanceColor = _getPerformanceColor(benchmark["performance"]);
              Color trendColor = _getTrendColor(benchmark["trend"]);
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${benchmark["metric"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${benchmark["category"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: performanceColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${benchmark["percentile"]}th percentile",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: performanceColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        _buildBenchmarkCard(
                          "Our Value",
                          "${benchmark["ourValue"]}${benchmark["unit"]}",
                          primaryColor,
                        ),
                        _buildBenchmarkCard(
                          "Industry Average",
                          "${benchmark["industryAverage"]}${benchmark["unit"]}",
                          warningColor,
                        ),
                        _buildBenchmarkCard(
                          "Top Performer",
                          "${benchmark["topPerformer"]}${benchmark["unit"]}",
                          successColor,
                        ),
                        _buildBenchmarkCard(
                          "Improvement",
                          "${(benchmark["improvement"] as double) >= 0 ? '+' : ''}${(benchmark["improvement"] as double).toStringAsFixed(1)}%",
                          trendColor,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: trendColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: trendColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            benchmark["trend"] == "improving" 
                                ? Icons.trending_up 
                                : benchmark["trend"] == "declining" 
                                    ? Icons.trending_down 
                                    : Icons.trending_flat,
                            color: trendColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Trend: ${benchmark["trend"].toString().toUpperCase()}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: trendColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBenchmarkCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitorsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Competitive Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: competitorData.map((competitor) {
                    bool isUs = competitor["name"] == "Our Company";
                    bool isIndustryAvg = competitor["name"] == "Industry Average";
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isUs 
                            ? primaryColor.withAlpha(15) 
                            : isIndustryAvg 
                                ? warningColor.withAlpha(10) 
                                : Colors.grey.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isUs 
                              ? primaryColor.withAlpha(30) 
                              : isIndustryAvg 
                                  ? warningColor.withAlpha(30) 
                                  : disabledColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${competitor["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: isUs ? primaryColor : isIndustryAvg ? warningColor : primaryColor,
                                  ),
                                ),
                              ),
                              if (!isIndustryAvg) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${competitor["strength"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          ResponsiveGridView(
                            padding: EdgeInsets.zero,
                            minItemWidth: 200,
                            children: [
                              _buildCompetitorMetric(
                                "Revenue",
                                "\$${(competitor["revenue"] as double).currency}",
                                Icons.attach_money,
                                successColor,
                              ),
                              _buildCompetitorMetric(
                                "Satisfaction",
                                "${competitor["customerSatisfaction"]}★",
                                Icons.star,
                                warningColor,
                              ),
                              _buildCompetitorMetric(
                                "Efficiency",
                                "${competitor["efficiency"]}%",
                                Icons.trending_up,
                                infoColor,
                              ),
                              _buildCompetitorMetric(
                                "Market Share",
                                "${competitor["marketShare"]}%",
                                Icons.pie_chart,
                                primaryColor,
                              ),
                            ],
                          ),
                          if (!isIndustryAvg && competitor["weakness"] != "N/A") ...[
                            Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: dangerColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Weakness: ${competitor["weakness"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitorMetric(String title, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInsightsTab() {
    List<Map<String, dynamic>> insights = [
      {
        "title": "Revenue Performance Strong",
        "description": "Our revenue performance is 27% above industry average, placing us in the 75th percentile.",
        "priority": "High",
        "type": "Strength",
        "recommendation": "Continue current revenue strategies and explore expansion opportunities.",
        "impact": "High"
      },
      {
        "title": "Service Speed Needs Improvement",
        "description": "Service speed is 22% slower than industry average and 14% slower than top performers.",
        "priority": "High",
        "type": "Weakness",
        "recommendation": "Implement process optimization and staff training programs.",
        "impact": "Medium"
      },
      {
        "title": "Market Share Growth Opportunity",
        "description": "Currently at 24.5% market share with room to grow toward top performer at 35.8%.",
        "priority": "Medium",
        "type": "Opportunity",
        "recommendation": "Develop targeted marketing campaigns and improve local presence.",
        "impact": "High"
      },
      {
        "title": "Employee Productivity Above Average",
        "description": "Sales per employee is 16.7% above industry standard, indicating efficient workforce.",
        "priority": "Low",
        "type": "Strength",
        "recommendation": "Maintain current productivity levels and consider best practice sharing.",
        "impact": "Medium"
      }
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Key Insights & Recommendations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spMd,
                  children: insights.map((insight) {
                    Color typeColor;
                    IconData typeIcon;
                    
                    switch (insight["type"]) {
                      case "Strength":
                        typeColor = successColor;
                        typeIcon = Icons.thumb_up;
                        break;
                      case "Weakness":
                        typeColor = dangerColor;
                        typeIcon = Icons.thumb_down;
                        break;
                      case "Opportunity":
                        typeColor = warningColor;
                        typeIcon = Icons.lightbulb;
                        break;
                      default:
                        typeColor = infoColor;
                        typeIcon = Icons.info;
                    }
                    
                    Color priorityColor = insight["priority"] == "High" 
                        ? dangerColor 
                        : insight["priority"] == "Medium" 
                            ? warningColor 
                            : successColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: typeColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spMd,
                        children: [
                          Row(
                            children: [
                              Icon(
                                typeIcon,
                                color: typeColor,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${insight["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: priorityColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${insight["priority"]} Priority",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: priorityColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${insight["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lightbulb_outline,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Recommendation",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${insight["recommendation"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: typeColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${insight["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: typeColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${insight["impact"]} Impact",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
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
            color: color,
          ),
        ),
      ],
    );
  }
}

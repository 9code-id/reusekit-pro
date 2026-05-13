import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmPerformanceAnalyticsView extends StatefulWidget {
  const TpmPerformanceAnalyticsView({super.key});

  @override
  State<TpmPerformanceAnalyticsView> createState() => _TpmPerformanceAnalyticsViewState();
}

class _TpmPerformanceAnalyticsViewState extends State<TpmPerformanceAnalyticsView> {
  String selectedMetric = "productivity";
  String selectedPeriod = "monthly";
  String selectedTeam = "all";
  bool showComparison = false;

  List<Map<String, dynamic>> metrics = [
    {"label": "Productivity", "value": "productivity"},
    {"label": "Quality", "value": "quality"},
    {"label": "Efficiency", "value": "efficiency"},
    {"label": "Delivery", "value": "delivery"},
    {"label": "Innovation", "value": "innovation"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> teams = [
    {"label": "All Teams", "value": "all"},
    {"label": "Development", "value": "development"},
    {"label": "Design", "value": "design"},
    {"label": "QA", "value": "qa"},
    {"label": "DevOps", "value": "devops"},
  ];

  List<Map<String, dynamic>> performanceData = [
    {
      "team": "Development",
      "productivity": 92,
      "quality": 88,
      "efficiency": 90,
      "delivery": 85,
      "innovation": 78,
      "improvement": 5.2,
      "members": 15,
      "projects": 8,
      "color": primaryColor,
    },
    {
      "team": "Design",
      "productivity": 89,
      "quality": 94,
      "efficiency": 87,
      "delivery": 91,
      "innovation": 85,
      "improvement": 3.8,
      "members": 8,
      "projects": 5,
      "color": successColor,
    },
    {
      "team": "QA",
      "productivity": 95,
      "quality": 96,
      "efficiency": 93,
      "delivery": 89,
      "innovation": 72,
      "improvement": 4.1,
      "members": 6,
      "projects": 12,
      "color": warningColor,
    },
    {
      "team": "DevOps",
      "productivity": 88,
      "quality": 85,
      "efficiency": 92,
      "delivery": 94,
      "innovation": 82,
      "improvement": 6.7,
      "members": 4,
      "projects": 15,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> kpiData = [
    {
      "title": "Team Velocity",
      "value": "8.7",
      "unit": "points/sprint",
      "change": 12.5,
      "target": 9.0,
      "icon": Icons.speed,
      "color": primaryColor,
    },
    {
      "title": "Code Quality",
      "value": "94.2%",
      "unit": "score",
      "change": 2.8,
      "target": 95.0,
      "icon": Icons.verified,
      "color": successColor,
    },
    {
      "title": "Bug Resolution",
      "value": "2.3",
      "unit": "days avg",
      "change": -15.2,
      "target": 2.0,
      "icon": Icons.bug_report,
      "color": warningColor,
    },
    {
      "title": "Client Satisfaction",
      "value": "4.6",
      "unit": "/5.0",
      "change": 8.3,
      "target": 4.5,
      "icon": Icons.star,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> benchmarkData = [
    {
      "metric": "Task Completion Rate",
      "current": 89,
      "target": 92,
      "industry": 85,
      "trend": "improving",
    },
    {
      "metric": "Time to Market",
      "current": 87,
      "target": 90,
      "industry": 82,
      "trend": "stable",
    },
    {
      "metric": "Customer Satisfaction",
      "current": 92,
      "target": 95,
      "industry": 88,
      "trend": "improving",
    },
    {
      "metric": "Team Retention",
      "current": 94,
      "target": 95,
      "industry": 87,
      "trend": "stable",
    },
  ];

  List<Map<String, dynamic>> trendData = [
    {"month": "Jan", "productivity": 85, "quality": 82, "delivery": 79},
    {"month": "Feb", "productivity": 87, "quality": 85, "delivery": 83},
    {"month": "Mar", "productivity": 89, "quality": 88, "delivery": 86},
    {"month": "Apr", "productivity": 91, "quality": 90, "delivery": 89},
    {"month": "May", "productivity": 93, "quality": 92, "delivery": 91},
    {"month": "Jun", "productivity": 92, "quality": 94, "delivery": 90},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Performance Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.compare),
            onPressed: () {
              showComparison = !showComparison;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Performance analytics exported successfully");
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
            _buildKPIOverview(),
            _buildPerformanceMetrics(),
            if (showComparison) _buildBenchmarkComparison(),
            _buildTeamPerformance(),
            _buildTrendAnalysis(),
            _buildInsights(),
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
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Analytics Filters",
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
                  label: "Primary Metric",
                  items: metrics,
                  value: selectedMetric,
                  onChanged: (value, label) {
                    selectedMetric = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
          QDropdownField(
            label: "Team Focus",
            items: teams,
            value: selectedTeam,
            onChanged: (value, label) {
              selectedTeam = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKPIOverview() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: kpiData.map((kpi) {
        bool isOnTarget = kpi["change"] > 0;
        bool meetingTarget = _isMetricOnTarget(kpi);

        return Container(
          padding: EdgeInsets.all(spMd),
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (kpi["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      kpi["icon"] as IconData,
                      color: kpi["color"] as Color,
                      size: 24,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: (isOnTarget ? successColor : dangerColor).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isOnTarget ? Icons.trending_up : Icons.trending_down,
                          size: 12,
                          color: isOnTarget ? successColor : dangerColor,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${kpi["change"] > 0 ? '+' : ''}${(kpi["change"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isOnTarget ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "${kpi["title"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${kpi["value"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: kpi["color"] as Color,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${kpi["unit"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Target: ${kpi["target"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: meetingTarget ? successColor : warningColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    meetingTarget ? "On Target" : "Below Target",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: meetingTarget ? successColor : warningColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Performance Metrics Radar",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 250,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.radar,
                  size: 64,
                  color: primaryColor.withAlpha(100),
                ),
                SizedBox(height: spSm),
                Text(
                  "Performance Radar Chart",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "360-degree view of team performance across all metrics",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: metrics.take(3).map((metric) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${metric["label"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${_getMetricValue(metric["value"] as String)}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBenchmarkComparison() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Industry Benchmark Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...benchmarkData.map((benchmark) {
            Color trendColor = _getTrendColor(benchmark["trend"] as String);
            bool aboveIndustry = (benchmark["current"] as int) > (benchmark["industry"] as int);

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${benchmark["metric"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: trendColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${benchmark["trend"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: trendColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildBenchmarkBar("Current", benchmark["current"] as int, primaryColor),
                      SizedBox(width: spSm),
                      _buildBenchmarkBar("Target", benchmark["target"] as int, successColor),
                      SizedBox(width: spSm),
                      _buildBenchmarkBar("Industry", benchmark["industry"] as int, warningColor),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        aboveIndustry ? Icons.trending_up : Icons.trending_down,
                        size: 16,
                        color: aboveIndustry ? successColor : warningColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${aboveIndustry ? '+' : ''}${((benchmark["current"] as int) - (benchmark["industry"] as int))}% vs industry",
                        style: TextStyle(
                          fontSize: 12,
                          color: aboveIndustry ? successColor : warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBenchmarkBar(String label, int value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            "$value%",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamPerformance() {
    List<Map<String, dynamic>> filteredTeams = selectedTeam == "all" 
        ? performanceData 
        : performanceData.where((team) => team["team"].toLowerCase() == selectedTeam).toList();

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredTeams.map((team) {
        int primaryMetricValue = team[selectedMetric] as int;
        
        return Container(
          padding: EdgeInsets.all(spMd),
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (team["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.group,
                      color: team["color"] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${team["team"]} Team",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: team["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${team["members"]} members",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (team["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${selectedMetric.toUpperCase()}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "$primaryMetricValue%",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: team["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: primaryMetricValue / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(team["color"] as Color),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildPerformanceStat("Quality", "${team["quality"]}%", Icons.verified),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildPerformanceStat("Delivery", "${team["delivery"]}%", Icons.local_shipping),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildPerformanceStat("Efficiency", "${team["efficiency"]}%", Icons.speed),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildPerformanceStat("Innovation", "${team["innovation"]}%", Icons.lightbulb),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, size: 16, color: successColor),
                    SizedBox(width: 4),
                    Text(
                      "+${(team["improvement"] as double).toStringAsFixed(1)}% improvement",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${team["projects"]} projects",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Detailed Report",
                  size: bs.sm,
                  icon: Icons.analytics,
                  onPressed: () {
                    ss("Generating detailed report for ${team["team"]} team");
                  },
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPerformanceStat(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Performance Trends (6 Months)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
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
                  "Performance Trend Lines",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Interactive chart showing performance trends over time",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildTrendSummary("Productivity", "+8.2%", Icons.trending_up, successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildTrendSummary("Quality", "+12.1%", Icons.trending_up, successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildTrendSummary("Delivery", "+15.2%", Icons.trending_up, successColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendSummary(String metric, String change, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          Text(
            metric,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            change,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsights() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                "Performance Insights & Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Full Report",
                size: bs.sm,
                icon: Icons.description,
                onPressed: () {
                  ss("Generating comprehensive performance report");
                },
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.insights, color: successColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Key Insights",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Development team shows consistent productivity improvement (+5.2% this month)",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• QA team exceeds quality metrics by 15% above industry benchmark",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• DevOps delivery performance improved significantly (+6.7% growth)",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Overall team satisfaction correlates with innovation metrics",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Recommendations",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Focus on innovation initiatives to boost creative output across teams",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Implement cross-team collaboration sessions to share best practices",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Consider additional training for teams below benchmark metrics",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Schedule Review",
                  size: bs.sm,
                  icon: Icons.event,
                  onPressed: () {
                    ss("Performance review meeting scheduled");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Export Analytics",
                  size: bs.sm,
                  icon: Icons.download,
                  onPressed: () {
                    ss("Performance analytics exported");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isMetricOnTarget(Map<String, dynamic> kpi) {
    double current = double.tryParse(kpi["value"].toString().replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
    double target = kpi["target"] as double;
    return current >= target;
  }

  int _getMetricValue(String metric) {
    // Simulate getting metric value based on selected metric
    switch (metric) {
      case "productivity":
        return 91;
      case "quality":
        return 89;
      case "efficiency":
        return 87;
      case "delivery":
        return 90;
      case "innovation":
        return 79;
      default:
        return 85;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "improving":
        return successColor;
      case "stable":
        return primaryColor;
      case "declining":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}

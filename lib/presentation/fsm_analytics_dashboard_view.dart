import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmAnalyticsDashboardView extends StatefulWidget {
  const FsmAnalyticsDashboardView({super.key});

  @override
  State<FsmAnalyticsDashboardView> createState() => _FsmAnalyticsDashboardViewState();
}

class _FsmAnalyticsDashboardViewState extends State<FsmAnalyticsDashboardView> {
  int currentTab = 0;
  String selectedTimeframe = "this_month";
  String selectedRegion = "all";
  String selectedService = "all";
  bool showTrends = true;
  bool autoRefresh = true;

  List<Map<String, dynamic>> overviewMetrics = [
    {
      "title": "Total Jobs",
      "value": 1247,
      "change": "+8.3%",
      "trend": "increasing",
      "target": 1200,
      "icon": Icons.work,
      "color": primaryColor
    },
    {
      "title": "Revenue",
      "value": 156780.0,
      "change": "+12.5%",
      "trend": "increasing",
      "target": 150000.0,
      "icon": Icons.attach_money,
      "color": successColor
    },
    {
      "title": "Customer Satisfaction",
      "value": 4.3,
      "change": "+0.2",
      "trend": "increasing",
      "target": 4.5,
      "icon": Icons.star,
      "color": warningColor
    },
    {
      "title": "Completion Rate",
      "value": 94.7,
      "change": "-1.2%",
      "trend": "decreasing",
      "target": 95.0,
      "icon": Icons.check_circle,
      "color": infoColor
    },
    {
      "title": "Response Time",
      "value": 2.4,
      "change": "-0.3h",
      "trend": "improving",
      "target": 2.0,
      "icon": Icons.timer,
      "color": dangerColor
    },
    {
      "title": "Active Technicians",
      "value": 48,
      "change": "+2",
      "trend": "stable",
      "target": 50,
      "icon": Icons.person,
      "color": primaryColor
    }
  ];

  List<Map<String, dynamic>> revenueData = [
    {"month": "Jan", "revenue": 125000, "target": 120000, "jobs": 980},
    {"month": "Feb", "revenue": 134000, "target": 125000, "jobs": 1050},
    {"month": "Mar", "revenue": 142000, "target": 130000, "jobs": 1120},
    {"month": "Apr", "revenue": 156780, "target": 150000, "jobs": 1247},
  ];

  List<Map<String, dynamic>> serviceBreakdown = [
    {"service": "HVAC", "percentage": 35.2, "revenue": 55185.0, "jobs": 438},
    {"service": "Plumbing", "percentage": 28.7, "revenue": 44996.0, "jobs": 358},
    {"service": "Electrical", "percentage": 22.1, "revenue": 34648.0, "jobs": 276},
    {"service": "General Maintenance", "percentage": 14.0, "revenue": 21951.0, "jobs": 175},
  ];

  List<Map<String, dynamic>> regionPerformance = [
    {
      "region": "North District",
      "jobs": 342,
      "revenue": 45230.0,
      "satisfaction": 4.5,
      "completion_rate": 96.2,
      "technicians": 12,
      "trend": "increasing"
    },
    {
      "region": "South District", 
      "jobs": 298,
      "revenue": 38940.0,
      "satisfaction": 4.2,
      "completion_rate": 94.1,
      "technicians": 10,
      "trend": "stable"
    },
    {
      "region": "East District",
      "jobs": 387,
      "revenue": 52340.0,
      "satisfaction": 4.4,
      "completion_rate": 95.8,
      "technicians": 15,
      "trend": "increasing"
    },
    {
      "region": "West District",
      "jobs": 220,
      "revenue": 20270.0,
      "satisfaction": 3.9,
      "completion_rate": 91.5,
      "technicians": 11,
      "trend": "decreasing"
    }
  ];

  List<Map<String, dynamic>> technicianAnalytics = [
    {
      "name": "Mike Chen",
      "jobs_completed": 67,
      "revenue_generated": 8940.0,
      "avg_rating": 4.8,
      "efficiency": 96.5,
      "specialization": "HVAC",
      "utilization": 89.2
    },
    {
      "name": "Lisa Wang",
      "jobs_completed": 72,
      "revenue_generated": 9860.0,
      "avg_rating": 4.9,
      "efficiency": 98.1,
      "specialization": "Electrical",
      "utilization": 92.4
    },
    {
      "name": "John Smith",
      "jobs_completed": 45,
      "revenue_generated": 5230.0,
      "avg_rating": 3.2,
      "efficiency": 78.9,
      "specialization": "Plumbing",
      "utilization": 73.6
    },
    {
      "name": "Alex Rodriguez",
      "jobs_completed": 58,
      "revenue_generated": 7120.0,
      "avg_rating": 4.4,
      "efficiency": 91.3,
      "specialization": "General",
      "utilization": 85.7
    }
  ];

  List<Map<String, dynamic>> alertsData = [
    {
      "type": "performance",
      "title": "Low Customer Satisfaction Alert",
      "description": "West District satisfaction dropped below 4.0",
      "severity": "high",
      "time": "2h ago",
      "action_required": true
    },
    {
      "type": "resource",
      "title": "High Demand Period",
      "description": "North District requests 25% above normal",
      "severity": "medium",
      "time": "4h ago",
      "action_required": false
    },
    {
      "type": "financial",
      "title": "Revenue Target Exceeded",
      "description": "Monthly target reached 3 days early",
      "severity": "low",
      "time": "1d ago",
      "action_required": false
    }
  ];

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "increasing":
      case "improving": return successColor;
      case "decreasing": return dangerColor;
      default: return warningColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "high": return dangerColor;
      case "medium": return warningColor;
      default: return infoColor;
    }
  }

  Widget _buildOverviewDashboard() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Time Filter
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: [
                    {"label": "This Week", "value": "this_week"},
                    {"label": "This Month", "value": "this_month"},
                    {"label": "Last 3 Months", "value": "last_3_months"},
                    {"label": "This Year", "value": "this_year"},
                  ],
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Key Metrics Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: overviewMetrics.map((metric) {
              Color trendColor = _getTrendColor("${metric["trend"]}");
              double progress = 0.0;
              
              if (metric["value"] is double) {
                progress = (metric["value"] as double) / (metric["target"] as double);
              } else {
                progress = (metric["value"] as int) / (metric["target"] as num);
              }
              
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
                        Icon(
                          metric["icon"] as IconData,
                          color: metric["color"] as Color,
                          size: 24,
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: trendColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${metric["change"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: trendColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    
                    Text(
                      metric["title"] == "Revenue" 
                          ? "\$${((metric["value"] as double) / 1000).toStringAsFixed(0)}K"
                          : metric["title"] == "Customer Satisfaction" || metric["title"] == "Response Time"
                              ? "${(metric["value"] as double).toStringAsFixed(1)}"
                              : "${metric["value"]}${metric["title"].contains("Rate") || metric["title"].contains("Satisfaction") ? "%" : ""}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    LinearProgressIndicator(
                      value: progress > 1.0 ? 1.0 : progress,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation(
                        progress >= 1.0 ? successColor : 
                        progress >= 0.8 ? warningColor : dangerColor
                      ),
                    ),
                    SizedBox(height: spXs),
                    
                    Text(
                      "Target: ${metric["target"]}${metric["title"].contains("Rate") ? "%" : metric["title"] == "Revenue" ? "K" : ""}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Revenue Chart
          Container(
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
                    Expanded(
                      child: Text(
                        "Revenue Trend",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Icon(Icons.trending_up, color: successColor, size: 20),
                  ],
                ),
                SizedBox(height: spMd),
                
                Container(
                  height: 200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: revenueData.map((data) {
                      double revenue = data["revenue"] as double;
                      double maxRevenue = revenueData.map((d) => d["revenue"] as double).reduce((a, b) => a > b ? a : b);
                      double height = (revenue / maxRevenue) * 160;
                      
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(revenue / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                height: height,
                                decoration: BoxDecoration(
                                  color: revenue >= (data["target"] as double) ? successColor : warningColor,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${data["month"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Service Breakdown
          Container(
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
                  "Service Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                ...serviceBreakdown.map((service) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${service["service"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${(service["percentage"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: (service["percentage"] as double) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation(primaryColor),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${service["jobs"]} jobs",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${((service["revenue"] as double) / 1000).toStringAsFixed(1)}K",
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
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionalAnalytics() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Region Performance Cards
          ...regionPerformance.map((region) {
            Color trendColor = _getTrendColor("${region["trend"]}");
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: trendColor,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${region["region"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${region["technicians"]} technicians • ${region["jobs"]} jobs",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: trendColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${region["trend"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: trendColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Metrics Grid
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildRegionMetric("Revenue", "\$${((region["revenue"] as double) / 1000).toStringAsFixed(1)}K", successColor),
                      _buildRegionMetric("Satisfaction", "${(region["satisfaction"] as double).toStringAsFixed(1)}", warningColor),
                      _buildRegionMetric("Completion", "${(region["completion_rate"] as double).toStringAsFixed(1)}%", infoColor),
                      _buildRegionMetric("Jobs/Tech", "${((region["jobs"] as int) / (region["technicians"] as int)).toStringAsFixed(1)}", primaryColor),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),

          // Regional Comparison
          Container(
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
                  "Regional Performance Comparison",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),

                // Jobs Comparison
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(15),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jobs Completed",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...regionPerformance.map((region) {
                        int maxJobs = regionPerformance.map((r) => r["jobs"] as int).reduce((a, b) => a > b ? a : b);
                        double progress = (region["jobs"] as int) / maxJobs;
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "${region["region"]}".split(" ")[0],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: disabledColor,
                                  valueColor: AlwaysStoppedAnimation(infoColor),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${region["jobs"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceReports() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Top Performers
          Container(
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
                  "Top Performing Technicians",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                ...technicianAnalytics.map((tech) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(15),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryColor.withAlpha(25),
                          child: Text(
                            "${tech["name"]}".split(" ").map((n) => n[0]).join(""),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${tech["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${tech["specialization"]} • ${tech["jobs_completed"]} jobs",
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
                              "\$${((tech["revenue_generated"] as double) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "${(tech["avg_rating"] as double).toStringAsFixed(1)} ⭐",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
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
          ),

          // Alerts & Notifications
          Container(
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
                  "System Alerts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                ...alertsData.map((alert) {
                  Color severityColor = _getSeverityColor("${alert["severity"]}");
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: severityColor.withAlpha(15),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: severityColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          alert["type"] == "performance" ? Icons.warning :
                          alert["type"] == "resource" ? Icons.trending_up : Icons.attach_money,
                          color: severityColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${alert["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${alert["description"]}",
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
                              "${alert["time"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (alert["action_required"] as bool)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Action Required",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: dangerColor,
                                  ),
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
          ),

          // Export & Settings
          Container(
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
                  "Report Settings",
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
                      child: Text(
                        "Show Trend Indicators",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: showTrends,
                      onChanged: (value) {
                        showTrends = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Auto Refresh Data",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: autoRefresh,
                      onChanged: (value) {
                        autoRefresh = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export PDF",
                        icon: Icons.picture_as_pdf,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Export Excel",
                        icon: Icons.table_chart,
                        size: bs.sm,
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
    );
  }

  Widget _buildRegionMetric(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Analytics Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Regions", icon: Icon(Icons.location_on)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewDashboard(),
        _buildRegionalAnalytics(),
        _buildPerformanceReports(),
      ],
    );
  }
}

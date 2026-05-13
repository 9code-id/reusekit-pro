import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDashboard10View extends StatefulWidget {
  @override
  State<GrlDashboard10View> createState() => _GrlDashboard10ViewState();
}

class _GrlDashboard10ViewState extends State<GrlDashboard10View> {
  bool loading = false;
  String selectedPeriod = "today";
  String selectedCategory = "all";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Technology", "value": "technology"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Finance", "value": "finance"},
    {"label": "Education", "value": "education"},
  ];

  List<Map<String, dynamic>> kpiMetrics = [
    {
      "title": "Total Revenue",
      "value": 2850000,
      "change": 12.5,
      "icon": Icons.trending_up,
      "color": "success",
    },
    {
      "title": "Active Users",
      "value": 45230,
      "change": 8.3,
      "icon": Icons.people,
      "color": "primary",
    },
    {
      "title": "Conversion Rate",
      "value": 3.2,
      "change": -2.1,
      "icon": Icons.trending_up,
      "color": "warning",
    },
    {
      "title": "Customer Satisfaction",
      "value": 4.8,
      "change": 0.3,
      "icon": Icons.star,
      "color": "info",
    },
  ];

  List<Map<String, dynamic>> topPerformers = [
    {
      "name": "Sarah Johnson",
      "department": "Sales",
      "score": 98.5,
      "target": 95.0,
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "badge": "Top Performer",
    },
    {
      "name": "Michael Chen",
      "department": "Marketing",
      "score": 96.2,
      "target": 90.0,
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "badge": "Rising Star",
    },
    {
      "name": "Emily Davis",
      "department": "Customer Success",
      "score": 94.8,
      "target": 88.0,
      "avatar": "https://picsum.photos/100/100?random=3&keyword=professional",
      "badge": "Excellence",
    },
    {
      "name": "James Wilson",
      "department": "Product",
      "score": 93.1,
      "target": 85.0,
      "avatar": "https://picsum.photos/100/100?random=4&keyword=business",
      "badge": "Innovator",
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "type": "sale",
      "title": "New Enterprise Sale",
      "description": "Closed \$125,000 deal with TechCorp Inc.",
      "time": "2 minutes ago",
      "icon": Icons.attach_money,
      "user": "Sarah Johnson",
    },
    {
      "type": "user",
      "title": "New User Registration",
      "description": "250 new users signed up today",
      "time": "15 minutes ago",
      "icon": Icons.person_add,
      "user": "System",
    },
    {
      "type": "feature",
      "title": "Feature Release",
      "description": "Mobile app v2.1 deployed successfully",
      "time": "1 hour ago",
      "icon": Icons.rocket_launch,
      "user": "Development Team",
    },
    {
      "type": "support",
      "title": "Support Ticket Resolved",
      "description": "Critical issue fixed for Premium customer",
      "time": "2 hours ago",
      "icon": Icons.support_agent,
      "user": "Emily Davis",
    },
    {
      "type": "milestone",
      "title": "Milestone Achieved",
      "description": "Reached 50K active monthly users",
      "time": "3 hours ago",
      "icon": Icons.flag,
      "user": "Product Team",
    },
  ];

  List<Map<String, dynamic>> departmentPerformance = [
    {
      "name": "Sales",
      "current": 142.5,
      "target": 120.0,
      "progress": 0.95,
      "trend": "up",
      "color": successColor,
    },
    {
      "name": "Marketing",
      "current": 89.2,
      "target": 100.0,
      "progress": 0.78,
      "trend": "down",
      "color": warningColor,
    },
    {
      "name": "Customer Success",
      "current": 95.8,
      "target": 90.0,
      "progress": 0.88,
      "trend": "up",
      "color": primaryColor,
    },
    {
      "name": "Product",
      "current": 78.3,
      "target": 85.0,
      "progress": 0.72,
      "trend": "stable",
      "color": infoColor,
    },
    {
      "name": "Operations",
      "current": 103.7,
      "target": 95.0,
      "progress": 0.92,
      "trend": "up",
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> get filteredPerformers {
    if (selectedCategory == "all") return topPerformers;
    return topPerformers.where((performer) {
      return performer["department"].toString().toLowerCase().contains(selectedCategory);
    }).toList();
  }

  Color _getKpiColor(String colorType) {
    switch (colorType) {
      case "success":
        return successColor;
      case "primary":
        return primaryColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case "sale":
        return successColor;
      case "user":
        return primaryColor;
      case "feature":
        return infoColor;
      case "support":
        return warningColor;
      case "milestone":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Executive Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              loading = true;
              setState(() {});
              Future.delayed(Duration(seconds: 2), () {
                loading = false;
                setState(() {});
              });
            },
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filters
                  Row(
                    children: [
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
                          label: "Category",
                          items: categoryOptions,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // KPI Metrics
                  Text(
                    "Key Performance Indicators",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: kpiMetrics.map((metric) {
                      Color metricColor = _getKpiColor("${metric["color"]}");
                      bool isPositive = (metric["change"] as double) >= 0;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: metricColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    metric["icon"] as IconData,
                                    color: metricColor,
                                    size: 20,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isPositive
                                        ? successColor.withAlpha(20)
                                        : dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        isPositive
                                            ? Icons.trending_up
                                            : Icons.trending_down,
                                        size: 12,
                                        color: isPositive ? successColor : dangerColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${(metric["change"] as double).abs().toStringAsFixed(1)}%",
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
                              "${metric["title"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              metric["title"] == "Conversion Rate" || metric["title"] == "Customer Satisfaction"
                                  ? "${(metric["value"] as double).toStringAsFixed(1)}${metric["title"] == "Customer Satisfaction" ? "★" : "%"}"
                                  : "${(metric["value"] as int).toString()}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  // Top Performers
                  Text(
                    "Top Performers",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: filteredPerformers.map((performer) {
                      double progress = (performer["score"] as double) / 100;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  child: Image.network(
                                    "${performer["avatar"]}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${performer["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${performer["department"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${performer["badge"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Score: ${(performer["score"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Target: ${(performer["target"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            LinearProgressIndicator(
                              value: progress,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                progress >= 0.9 ? successColor : 
                                progress >= 0.7 ? warningColor : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  // Department Performance
                  Text(
                    "Department Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: departmentPerformance.map((dept) {
                        IconData trendIcon = dept["trend"] == "up"
                            ? Icons.trending_up
                            : dept["trend"] == "down"
                                ? Icons.trending_down
                                : Icons.trending_flat;
                        
                        return Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (dept["color"] as Color).withAlpha(5),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: dept["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${dept["name"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          trendIcon,
                                          size: 16,
                                          color: dept["trend"] == "up"
                                              ? successColor
                                              : dept["trend"] == "down"
                                                  ? dangerColor
                                                  : disabledBoldColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Text(
                                          "${(dept["current"] as double).toStringAsFixed(1)}%",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dept["color"] as Color,
                                          ),
                                        ),
                                        Text(
                                          " / ${(dept["target"] as double).toStringAsFixed(1)}%",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 60,
                                          child: LinearProgressIndicator(
                                            value: dept["progress"] as double,
                                            backgroundColor: disabledColor,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              dept["color"] as Color,
                                            ),
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
                      }).toList(),
                    ),
                  ),

                  // Recent Activities
                  Text(
                    "Recent Activities",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: recentActivities.map((activity) {
                        Color activityColor = _getActivityColor("${activity["type"]}");
                        
                        return Container(
                          padding: EdgeInsets.all(spXs),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: activityColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  activity["icon"] as IconData,
                                  color: activityColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${activity["title"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${activity["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Text(
                                          "${activity["user"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: activityColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${activity["time"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
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
                      }).toList(),
                    ),
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Full Report",
                          size: bs.md,
                          onPressed: () {
                            //navigateTo('FullReportView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export Data",
                          size: bs.md,
                          onPressed: () {
                            //navigateTo('ExportView')
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

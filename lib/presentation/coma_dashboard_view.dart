import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaDashboardView extends StatefulWidget {
  const ComaDashboardView({super.key});

  @override
  State<ComaDashboardView> createState() => _ComaDashboardViewState();
}

class _ComaDashboardViewState extends State<ComaDashboardView> {
  String selectedTimeframe = "week";
  int currentTab = 0;

  List<Map<String, dynamic>> timeframes = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Project Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
        Tab(text: "Tasks", icon: Icon(Icons.task)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAnalyticsTab(),
        _buildReportsTab(),
        _buildTasksTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    List<Map<String, dynamic>> keyMetrics = [
      {"title": "Total Revenue", "value": 2450000, "change": 12, "icon": Icons.monetization_on, "color": successColor},
      {"title": "Active Projects", "value": 15, "change": 3, "icon": Icons.construction, "color": primaryColor},
      {"title": "Team Utilization", "value": 87, "unit": "%", "change": 5, "icon": Icons.people, "color": infoColor},
      {"title": "On-Time Delivery", "value": 94, "unit": "%", "change": -2, "icon": Icons.schedule, "color": warningColor},
    ];

    List<Map<String, dynamic>> projectAlerts = [
      {
        "project": "Downtown Office Complex",
        "type": "Budget Alert",
        "message": "Project is 15% over budget",
        "severity": "high",
        "date": "2 hours ago",
      },
      {
        "project": "Residential Villa",
        "type": "Schedule Delay",
        "message": "Delivery delayed by 3 days",
        "severity": "medium",
        "date": "5 hours ago",
      },
      {
        "project": "Mall Renovation",
        "type": "Resource Needed",
        "message": "Additional electricians required",
        "severity": "low",
        "date": "1 day ago",
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Filter
          Row(
            children: [
              Text(
                "Performance Overview",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                width: 140,
                child: QDropdownField(
                  label: "",
                  items: timeframes,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Key Metrics Grid
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: keyMetrics.map((metric) {
              bool isPositive = (metric["change"] as int) > 0;
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            metric["icon"],
                            color: metric["color"],
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              isPositive ? Icons.trending_up : Icons.trending_down,
                              color: isPositive ? successColor : dangerColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${isPositive ? '+' : ''}${metric["change"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: isPositive ? successColor : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          metric["title"] == "Total Revenue"
                              ? "\$${((metric["value"] as int).toDouble()).currency}"
                              : "${metric["value"]}${metric["unit"] ?? ""}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${metric["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Project Status Chart Placeholder
          Container(
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
                  "Project Status Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: Column(
                    spacing: spSm,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pie_chart,
                        size: 64,
                        color: disabledColor,
                      ),
                      Text(
                        "Chart visualization would be implemented here",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Project Alerts
          Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Project Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spSm,
                children: projectAlerts.map((alert) {
                  Color alertColor = alert["severity"] == "high"
                      ? dangerColor
                      : alert["severity"] == "medium"
                          ? warningColor
                          : infoColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: alertColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    alert["severity"] == "high"
                                        ? Icons.error
                                        : alert["severity"] == "medium"
                                            ? Icons.warning
                                            : Icons.info,
                                    color: alertColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${alert["type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: alertColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${alert["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${alert["project"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${alert["message"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            height: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.analytics,
                  size: 64,
                  color: disabledColor,
                ),
                Text(
                  "Advanced Analytics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Detailed analytics and charts would be implemented here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
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

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            height: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assessment,
                  size: 64,
                  color: disabledColor,
                ),
                Text(
                  "Reports & Documentation",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Generate and manage project reports",
                  textAlign: TextAlign.center,
                  style: TextStyle(
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

  Widget _buildTasksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            height: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.task,
                  size: 64,
                  color: disabledColor,
                ),
                Text(
                  "Task Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Manage all project tasks and assignments",
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
}

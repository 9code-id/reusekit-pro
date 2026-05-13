import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaDashboardView extends StatefulWidget {
  const CmaDashboardView({super.key});

  @override
  State<CmaDashboardView> createState() => _CmaDashboardViewState();
}

class _CmaDashboardViewState extends State<CmaDashboardView> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "CMA Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Projects", icon: Icon(Icons.assignment)),
        Tab(text: "Finance", icon: Icon(Icons.attach_money)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildProjectsTab(),
        _buildFinanceTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }

  Widget _buildOverviewTab() {
    List<Map<String, dynamic>> keyMetrics = [
      {
        "title": "Total Revenue",
        "value": 8450000.0,
        "change": 12.5,
        "icon": Icons.attach_money,
        "color": successColor,
      },
      {
        "title": "Active Projects",
        "value": 12.0,
        "change": 8.3,
        "icon": Icons.assignment,
        "color": primaryColor,
      },
      {
        "title": "Team Members",
        "value": 47.0,
        "change": 15.2,
        "icon": Icons.people,
        "color": infoColor,
      },
      {
        "title": "Client Satisfaction",
        "value": 94.5,
        "change": 3.1,
        "icon": Icons.star,
        "color": warningColor,
      },
    ];

    List<Map<String, dynamic>> recentActivities = [
      {
        "title": "New project started: Downtown Complex",
        "time": "2 hours ago",
        "type": "project",
        "icon": Icons.play_arrow,
      },
      {
        "title": "Payment received from Riverside Development",
        "time": "4 hours ago",
        "type": "payment",
        "icon": Icons.payment,
      },
      {
        "title": "Safety inspection completed",
        "time": "Yesterday",
        "type": "inspection",
        "icon": Icons.verified,
      },
      {
        "title": "New team member added: Sarah Johnson",
        "time": "2 days ago",
        "type": "team",
        "icon": Icons.person_add,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Welcome Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good morning, John!",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Here's what's happening with your business today",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "June 18, 2025 • 9:30 AM",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(180),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(40),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.wb_sunny,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),

          // Key Metrics
          Text(
            "Key Metrics",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: keyMetrics.map((metric) {
              bool isPositive = (metric["change"] as double) > 0;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
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
                            metric["icon"] as IconData,
                            color: metric["color"] as Color,
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
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
                                isPositive ? Icons.trending_up : Icons.trending_down,
                                size: 12,
                                color: isPositive ? successColor : dangerColor,
                              ),
                              SizedBox(width: spXs),
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
                    SizedBox(height: spSm),
                    Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      metric["title"] == "Total Revenue" 
                        ? "\$${((metric["value"] as double) / 1000000).toStringAsFixed(1)}M"
                        : metric["title"] == "Client Satisfaction"
                          ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                          : "${(metric["value"] as double).toInt()}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: metric["color"] as Color,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Quick Actions
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: InkWell(
                    onTap: () {
                      ss("New project creation opened");
                    },
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Column(
                      children: [
                        Icon(Icons.add_circle, color: primaryColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "New Project",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: InkWell(
                    onTap: () {
                      ss("Team member addition opened");
                    },
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Column(
                      children: [
                        Icon(Icons.person_add, color: successColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "Add Team Member",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: InkWell(
                    onTap: () {
                      ss("Report generation opened");
                    },
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Column(
                      children: [
                        Icon(Icons.analytics, color: infoColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "Generate Report",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Recent Activities
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Activities",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  ss("Activity log opened");
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          ...recentActivities.map((activity) {
            Color activityColor;
            switch (activity["type"]) {
              case "project":
                activityColor = primaryColor;
                break;
              case "payment":
                activityColor = successColor;
                break;
              case "inspection":
                activityColor = warningColor;
                break;
              case "team":
                activityColor = infoColor;
                break;
              default:
                activityColor = disabledColor;
            }

            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: activityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
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
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${activity["time"]}",
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProjectsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment, size: 64, color: disabledColor),
          SizedBox(height: spSm),
          Text(
            "Projects Dashboard",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Detailed project management coming soon",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinanceTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.attach_money, size: 64, color: disabledColor),
          SizedBox(height: spSm),
          Text(
            "Financial Dashboard",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Financial analytics and reporting coming soon",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics, size: 64, color: disabledColor),
          SizedBox(height: spSm),
          Text(
            "Analytics Dashboard",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Advanced analytics and insights coming soon",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaDashboardView extends StatefulWidget {
  const RhaDashboardView({super.key});

  @override
  State<RhaDashboardView> createState() => _RhaDashboardViewState();
}

class _RhaDashboardViewState extends State<RhaDashboardView> {
  int currentTab = 0;

  List<Map<String, dynamic>> dashboardStats = [
    {
      "title": "Total Employees",
      "value": 248,
      "change": "+12",
      "isPositive": true,
      "icon": Icons.people,
      "description": "Active employees",
    },
    {
      "title": "New Hires",
      "value": 15,
      "change": "+5",
      "isPositive": true,
      "icon": Icons.person_add,
      "description": "This month",
    },
    {
      "title": "Open Positions",
      "value": 8,
      "change": "-2",
      "isPositive": false,
      "icon": Icons.work_outline,
      "description": "Currently hiring",
    },
    {
      "title": "Avg. Salary",
      "value": 75000,
      "change": "+5%",
      "isPositive": true,
      "icon": Icons.attach_money,
      "description": "Company average",
    },
  ];

  List<Map<String, dynamic>> departmentData = [
    {"name": "Engineering", "employees": 85, "budget": 2.5, "color": Colors.blue},
    {"name": "Sales", "employees": 45, "budget": 1.8, "color": Colors.green},
    {"name": "Marketing", "employees": 32, "budget": 1.2, "color": Colors.purple},
    {"name": "HR", "employees": 12, "budget": 0.8, "color": Colors.orange},
    {"name": "Finance", "employees": 18, "budget": 1.0, "color": Colors.red},
    {"name": "Operations", "employees": 56, "budget": 2.0, "color": Colors.teal},
  ];

  List<Map<String, dynamic>> recruitmentPipeline = [
    {"stage": "Applications", "count": 156, "color": Colors.blue},
    {"stage": "Screening", "count": 45, "color": Colors.green},
    {"stage": "Interviews", "count": 23, "color": Colors.orange},
    {"stage": "Final Review", "count": 8, "color": Colors.purple},
    {"stage": "Offers", "count": 3, "color": Colors.red},
  ];

  List<Map<String, dynamic>> recentHires = [
    {
      "name": "John Smith",
      "position": "Senior Developer",
      "department": "Engineering",
      "startDate": "March 15, 2024",
      "status": "Onboarding",
    },
    {
      "name": "Sarah Johnson",
      "position": "Marketing Manager",
      "department": "Marketing",
      "startDate": "March 10, 2024",
      "status": "Active",
    },
    {
      "name": "Mike Davis",
      "position": "Sales Representative",
      "department": "Sales",
      "startDate": "March 8, 2024",
      "status": "Active",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "HR Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Departments", icon: Icon(Icons.business)),
        Tab(text: "Recruitment", icon: Icon(Icons.person_search)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDepartmentsTab(),
        _buildRecruitmentTab(),
        _buildAnalyticsTab(),
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
          // Key Metrics
          Text(
            "Key Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: dashboardStats.map((stat) {
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            stat["icon"],
                            color: primaryColor,
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
                            color: (stat["isPositive"] as bool)
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${stat["change"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: (stat["isPositive"] as bool)
                                  ? successColor
                                  : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      stat["title"] == "Avg. Salary"
                          ? "\$${((stat["value"] as int) / 1000).toInt()}K"
                          : "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["description"]}",
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

          // Recent Hires
          Text(
            "Recent Hires",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: recentHires.map((hire) {
                int index = recentHires.indexOf(hire);
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: index < recentHires.length - 1
                            ? disabledOutlineBorderColor
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${hire["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${hire["position"]} • ${hire["department"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Started: ${hire["startDate"]}",
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
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: hire["status"] == "Active"
                              ? successColor.withAlpha(20)
                              : infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${hire["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: hire["status"] == "Active"
                                ? successColor
                                : infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Department Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: departmentData.map((dept) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: (dept["color"] as Color).withAlpha(30),
                    width: 2,
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: dept["color"],
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${dept["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${dept["employees"]} employees",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "\$${dept["budget"]}M budget",
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
        ],
      ),
    );
  }

  Widget _buildRecruitmentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recruitment Pipeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: recruitmentPipeline.map((stage) {
                return Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (stage["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "${stage["count"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: stage["color"],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${stage["stage"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (stage["count"] as int) / 156,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: stage["color"],
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "HR Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spLg,
              children: [
                Text(
                  "Detailed analytics and reports will be available here. Track employee performance, recruitment metrics, and organizational insights.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Full Analytics",
                    size: bs.md,
                    onPressed: () {
                      // ss('Next page'));
                    },
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

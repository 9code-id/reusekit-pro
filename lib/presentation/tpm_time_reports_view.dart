import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTimeReportsView extends StatefulWidget {
  const TpmTimeReportsView({super.key});

  @override
  State<TpmTimeReportsView> createState() => _TpmTimeReportsViewState();
}

class _TpmTimeReportsViewState extends State<TpmTimeReportsView> {
  int selectedTab = 0;
  String selectedPeriod = "month";
  String selectedEmployee = "all";
  String selectedProject = "all";
  String reportType = "summary";
  
  List<Map<String, dynamic>> periods = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
    {"label": "Custom Range", "value": "custom"},
  ];
  
  List<Map<String, dynamic>> employees = [
    {"label": "All Employees", "value": "all"},
    {"label": "Sarah Johnson", "value": "sarah"},
    {"label": "Mike Chen", "value": "mike"},
    {"label": "Emily Davis", "value": "emily"},
    {"label": "Alex Rodriguez", "value": "alex"},
    {"label": "Lisa Wang", "value": "lisa"},
  ];
  
  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "E-commerce Platform", "value": "ecommerce"},
    {"label": "Mobile App", "value": "mobile"},
    {"label": "Website Redesign", "value": "website"},
    {"label": "Marketing Campaign", "value": "marketing"},
  ];
  
  List<Map<String, dynamic>> reportTypes = [
    {"label": "Summary Report", "value": "summary"},
    {"label": "Detailed Report", "value": "detailed"},
    {"label": "Productivity Report", "value": "productivity"},
    {"label": "Billable Hours Report", "value": "billable"},
  ];
  
  List<Map<String, dynamic>> timeMetrics = [
    {
      "title": "Total Hours",
      "value": "1,248",
      "subtitle": "This month",
      "icon": Icons.schedule,
      "color": primaryColor,
      "change": 15.2
    },
    {
      "title": "Billable Hours",
      "value": "1,064",
      "subtitle": "85.3% of total",
      "icon": Icons.attach_money,
      "color": successColor,
      "change": 12.8
    },
    {
      "title": "Overtime Hours",
      "value": "89",
      "subtitle": "Above 40h/week",
      "icon": Icons.trending_up,
      "color": warningColor,
      "change": -5.3
    },
    {
      "title": "Efficiency Rate",
      "value": "94.2%",
      "subtitle": "Team average",
      "icon": Icons.speed,
      "color": infoColor,
      "change": 8.7
    },
  ];
  
  List<Map<String, dynamic>> projectReports = [
    {
      "project": "E-commerce Platform",
      "total_hours": 456.5,
      "billable_hours": 435.0,
      "team_members": 8,
      "completion": 0.78,
      "budget_used": 0.72,
      "efficiency": 92.5,
      "status": "On Track"
    },
    {
      "project": "Mobile App",
      "total_hours": 328.0,
      "billable_hours": 280.4,
      "team_members": 5,
      "completion": 0.65,
      "budget_used": 0.69,
      "efficiency": 88.3,
      "status": "Behind Schedule"
    },
    {
      "project": "Website Redesign",
      "total_hours": 198.5,
      "billable_hours": 189.2,
      "team_members": 4,
      "completion": 0.89,
      "budget_used": 0.85,
      "efficiency": 95.8,
      "status": "Almost Complete"
    },
    {
      "project": "Marketing Campaign",
      "total_hours": 124.0,
      "billable_hours": 98.5,
      "team_members": 3,
      "completion": 0.45,
      "budget_used": 0.38,
      "efficiency": 79.4,
      "status": "In Progress"
    },
  ];
  
  List<Map<String, dynamic>> employeeReports = [
    {
      "name": "Sarah Johnson",
      "role": "Frontend Developer",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
      "total_hours": 168.5,
      "billable_hours": 152.0,
      "overtime_hours": 8.5,
      "efficiency": 94.2,
      "projects": 3,
      "hourly_rate": 75.0
    },
    {
      "name": "Mike Chen",
      "role": "Backend Developer",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=man",
      "total_hours": 162.0,
      "billable_hours": 148.5,
      "overtime_hours": 12.0,
      "efficiency": 91.8,
      "projects": 2,
      "hourly_rate": 80.0
    },
    {
      "name": "Emily Davis",
      "role": "UI/UX Designer",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
      "total_hours": 156.0,
      "billable_hours": 140.4,
      "overtime_hours": 6.0,
      "efficiency": 88.7,
      "projects": 4,
      "hourly_rate": 65.0
    },
    {
      "name": "Alex Rodriguez",
      "role": "Project Manager",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=man",
      "total_hours": 160.0,
      "billable_hours": 128.0,
      "overtime_hours": 10.0,
      "efficiency": 85.3,
      "projects": 3,
      "hourly_rate": 90.0
    },
    {
      "name": "Lisa Wang",
      "role": "QA Engineer",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=woman",
      "total_hours": 152.0,
      "billable_hours": 136.8,
      "overtime_hours": 2.0,
      "efficiency": 92.8,
      "projects": 2,
      "hourly_rate": 55.0
    },
  ];
  
  List<Map<String, dynamic>> weeklyTrends = [
    {"week": "Week 1", "hours": 320, "billable": 276, "efficiency": 91.2},
    {"week": "Week 2", "hours": 315, "billable": 268, "efficiency": 89.8},
    {"week": "Week 3", "hours": 328, "billable": 285, "efficiency": 93.5},
    {"week": "Week 4", "hours": 312, "billable": 267, "efficiency": 88.7},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Time Reports",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Projects", icon: Icon(Icons.work)),
        Tab(text: "Employees", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildProjectsTab(),
        _buildEmployeesTab(),
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
          _buildFilters(),
          _buildTimeMetrics(),
          _buildTimeChart(),
          _buildWeeklyTrends(),
        ],
      ),
    );
  }

  Widget _buildProjectsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProjectFilters(),
          _buildProjectReports(),
        ],
      ),
    );
  }

  Widget _buildEmployeesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEmployeeFilters(),
          _buildEmployeeReports(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
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
                  items: periods,
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
                  label: "Report Type",
                  items: reportTypes,
                  value: reportType,
                  onChanged: (value, label) {
                    reportType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Employee",
                  items: employees,
                  value: selectedEmployee,
                  onChanged: (value, label) {
                    selectedEmployee = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: projects,
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
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

  Widget _buildProjectFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Project",
              items: projects,
              value: selectedProject,
              onChanged: (value, label) {
                selectedProject = value;
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
          SizedBox(width: spSm),
          QButton(
            label: "Export",
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Employee",
              items: employees,
              value: selectedEmployee,
              onChanged: (value, label) {
                selectedEmployee = value;
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
          SizedBox(width: spSm),
          QButton(
            label: "Export",
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTimeMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Time Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: timeMetrics.map((metric) => _buildMetricCard(metric)).toList(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    bool isPositive = (metric["change"] as double) >= 0;
    
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
                  color: (metric["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"],
                  color: metric["color"],
                  size: 20,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: isPositive ? successColor : dangerColor,
                      size: 12,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${isPositive ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
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
            ),
          ),
          Text(
            "${metric["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${metric["subtitle"]}",
            style: TextStyle(
              fontSize: 11,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeChart() {
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
                "Time Tracking Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
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
                    Icons.show_chart,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Time Tracking Chart",
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

  Widget _buildWeeklyTrends() {
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
            "Weekly Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...weeklyTrends.map((week) => _buildWeeklyTrendCard(week)),
        ],
      ),
    );
  }

  Widget _buildWeeklyTrendCard(Map<String, dynamic> week) {
    double billablePercent = ((week["billable"] as int) / (week["hours"] as int)) * 100;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            child: Text(
              "${week["week"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildWeekStat("Total", "${week["hours"]}h", primaryColor),
                ),
                Expanded(
                  child: _buildWeekStat("Billable", "${week["billable"]}h", successColor),
                ),
                Expanded(
                  child: _buildWeekStat("Rate", "${billablePercent.toStringAsFixed(1)}%", infoColor),
                ),
                Expanded(
                  child: _buildWeekStat("Efficiency", "${(week["efficiency"] as double).toStringAsFixed(1)}%", warningColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectReports() {
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
            "Project Time Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...projectReports.map((project) => _buildProjectReportCard(project)),
        ],
      ),
    );
  }

  Widget _buildProjectReportCard(Map<String, dynamic> project) {
    Color statusColor = _getStatusColor(project["status"]);
    double billableRate = ((project["billable_hours"] as double) / (project["total_hours"] as double)) * 100;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${project["project"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${project["team_members"]} team members",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${project["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildProjectStat("Total Hours", "${(project["total_hours"] as double).toStringAsFixed(1)}h", primaryColor),
              ),
              Expanded(
                child: _buildProjectStat("Billable Hours", "${(project["billable_hours"] as double).toStringAsFixed(1)}h", successColor),
              ),
              Expanded(
                child: _buildProjectStat("Billable Rate", "${billableRate.toStringAsFixed(1)}%", infoColor),
              ),
              Expanded(
                child: _buildProjectStat("Efficiency", "${(project["efficiency"] as double).toStringAsFixed(1)}%", warningColor),
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
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: project["completion"],
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${((project["completion"] as double) * 100).toInt()}% complete",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeReports() {
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
            "Employee Time Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...employeeReports.map((employee) => _buildEmployeeReportCard(employee)),
        ],
      ),
    );
  }

  Widget _buildEmployeeReportCard(Map<String, dynamic> employee) {
    double billableRate = ((employee["billable_hours"] as double) / (employee["total_hours"] as double)) * 100;
    double totalEarnings = (employee["billable_hours"] as double) * (employee["hourly_rate"] as double);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${employee["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${employee["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${employee["role"]} • ${employee["projects"]} projects",
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
                    "\$${totalEarnings.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Total Earnings",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildEmployeeStat("Total Hours", "${(employee["total_hours"] as double).toStringAsFixed(1)}h", primaryColor),
              ),
              Expanded(
                child: _buildEmployeeStat("Billable Hours", "${(employee["billable_hours"] as double).toStringAsFixed(1)}h", successColor),
              ),
              Expanded(
                child: _buildEmployeeStat("Overtime", "${(employee["overtime_hours"] as double).toStringAsFixed(1)}h", warningColor),
              ),
              Expanded(
                child: _buildEmployeeStat("Efficiency", "${(employee["efficiency"] as double).toStringAsFixed(1)}%", infoColor),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Billable Rate: ${billableRate.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Hourly Rate: \$${(employee["hourly_rate"] as double).toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "on track":
      case "almost complete":
        return successColor;
      case "behind schedule":
        return dangerColor;
      case "in progress":
        return warningColor;
      default:
        return infoColor;
    }
  }
}

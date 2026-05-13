import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaDashboardView extends StatefulWidget {
  const ImaDashboardView({super.key});

  @override
  State<ImaDashboardView> createState() => _ImaDashboardViewState();
}

class _ImaDashboardViewState extends State<ImaDashboardView> {
  int selectedTimeframe = 0;
  List<String> timeframes = ["This Week", "This Month", "Last Quarter", "This Year"];
  String selectedDepartment = "All";
  List<String> departments = ["All", "Sales", "Marketing", "Operations", "HR", "Finance"];
  
  List<Map<String, dynamic>> kpiMetrics = [
    {
      "title": "Revenue",
      "value": 2450000,
      "unit": "currency",
      "trend": 12.5,
      "icon": Icons.trending_up,
      "color": "success",
    },
    {
      "title": "Active Projects",
      "value": 47,
      "unit": "count",
      "trend": 8.3,
      "icon": Icons.work,
      "color": "primary",
    },
    {
      "title": "Team Efficiency",
      "value": 94.2,
      "unit": "percentage",
      "trend": 5.1,
      "icon": Icons.speed,
      "color": "warning",
    },
    {
      "title": "Customer Satisfaction",
      "value": 4.8,
      "unit": "rating",
      "trend": 2.7,
      "icon": Icons.star,
      "color": "info",
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "type": "project_completed",
      "title": "Project Alpha completed",
      "description": "Marketing campaign finished ahead of schedule",
      "timestamp": "2025-06-18T14:30:00",
      "user": "Sarah Johnson",
      "status": "success",
    },
    {
      "type": "budget_alert",
      "title": "Budget threshold reached",
      "description": "Q2 marketing budget at 85% utilization",
      "timestamp": "2025-06-18T13:15:00",
      "user": "System",
      "status": "warning",
    },
    {
      "type": "team_update",
      "title": "New team member added",
      "description": "John Smith joined the development team",
      "timestamp": "2025-06-18T11:45:00",
      "user": "HR Department",
      "status": "info",
    },
    {
      "type": "revenue_milestone",
      "title": "Revenue milestone achieved",
      "description": "Monthly target exceeded by 15%",
      "timestamp": "2025-06-18T09:20:00",
      "user": "Sales Team",
      "status": "success",
    },
  ];

  List<Map<String, dynamic>> departmentPerformance = [
    {
      "department": "Sales",
      "performance": 96.5,
      "target": 100.0,
      "projects": 12,
      "revenue": 980000,
      "efficiency": 94.2,
      "color": Colors.blue,
    },
    {
      "department": "Marketing",
      "performance": 88.3,
      "target": 85.0,
      "projects": 8,
      "revenue": 450000,
      "efficiency": 91.7,
      "color": Colors.green,
    },
    {
      "department": "Operations",
      "performance": 92.1,
      "target": 90.0,
      "projects": 15,
      "revenue": 720000,
      "efficiency": 89.4,
      "color": Colors.orange,
    },
    {
      "department": "HR",
      "performance": 85.7,
      "target": 80.0,
      "projects": 6,
      "revenue": 180000,
      "efficiency": 87.9,
      "color": Colors.purple,
    },
    {
      "department": "Finance",
      "performance": 94.8,
      "target": 95.0,
      "projects": 4,
      "revenue": 120000,
      "efficiency": 96.1,
      "color": Colors.red,
    },
  ];

  List<Map<String, dynamic>> aiInsights = [
    {
      "type": "optimization",
      "title": "Process Optimization Opportunity",
      "description": "AI detected 23% efficiency gain potential in procurement workflow",
      "impact": "High",
      "estimated_savings": 45000,
      "confidence": 87,
    },
    {
      "type": "prediction",
      "title": "Revenue Forecast Update",
      "description": "Q3 revenue projected to exceed target by 18% based on current trends",
      "impact": "Medium",
      "estimated_savings": 0,
      "confidence": 92,
    },
    {
      "type": "risk",
      "title": "Resource Allocation Risk",
      "description": "Development team utilization at 120% - recommend hiring 2 additional developers",
      "impact": "High",
      "estimated_savings": 0,
      "confidence": 78,
    },
  ];

  List<Map<String, dynamic>> upcomingTasks = [
    {
      "id": 1,
      "title": "Q2 Financial Review",
      "priority": "High",
      "deadline": "2025-06-20",
      "assignee": "Finance Team",
      "progress": 65,
      "type": "review",
    },
    {
      "id": 2,
      "title": "Product Launch Planning",
      "priority": "Medium",
      "deadline": "2025-06-25",
      "assignee": "Marketing Team",
      "progress": 40,
      "type": "planning",
    },
    {
      "id": 3,
      "title": "System Security Audit",
      "priority": "High",
      "deadline": "2025-06-22",
      "assignee": "IT Security",
      "progress": 20,
      "type": "audit",
    },
    {
      "id": 4,
      "title": "Employee Performance Reviews",
      "priority": "Medium",
      "deadline": "2025-06-30",
      "assignee": "HR Department",
      "progress": 80,
      "type": "evaluation",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredDepartments = selectedDepartment == "All" 
        ? departmentPerformance 
        : departmentPerformance.where((dept) => dept["department"] == selectedDepartment).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("IMA Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // navigateTo('NotificationsView')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo('DashboardSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Welcome Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Welcome back, Admin",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Here's your business overview for today",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.white.withAlpha(200),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Last updated: ${DateTime.now().toString().substring(11, 16)}",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.dashboard,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Time Frame Selector
            QCategoryPicker(
              items: timeframes.map((timeframe) => {
                "label": timeframe,
                "value": timeframe,
              }).toList(),
              value: timeframes[selectedTimeframe],
              onChanged: (index, label, value, item) {
                selectedTimeframe = index;
                setState(() {});
              },
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
              minItemWidth: 200,
              children: kpiMetrics.map((metric) {
                Color metricColor = _getMetricColor(metric["color"]);
                String formattedValue = _formatMetricValue(metric["value"], metric["unit"]);
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(color: metricColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: metricColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"],
                              color: metricColor,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  size: 12,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "+${(metric["trend"] as num).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        formattedValue,
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // AI Insights Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "AI Insights & Recommendations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: aiInsights.map((insight) {
                      Color impactColor = insight["impact"] == "High" 
                          ? dangerColor 
                          : insight["impact"] == "Medium" 
                              ? warningColor 
                              : successColor;

                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: impactColor.withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${insight["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
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
                                    color: impactColor.withAlpha(15),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${insight["impact"]} Impact",
                                    style: TextStyle(
                                      color: impactColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${insight["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              children: [
                                if ((insight["estimated_savings"] as int) > 0) ...[
                                  Icon(
                                    Icons.savings,
                                    size: 14,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Est. Savings: \$${((insight["estimated_savings"] as int).toDouble()).currency}",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                ],
                                Icon(
                                  Icons.verified,
                                  size: 14,
                                  color: infoColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${insight["confidence"]}% Confidence",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
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

            // Department Performance
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Department Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  child: QDropdownField(
                    label: "Department",
                    items: departments.map((dept) => {
                      "label": dept,
                      "value": dept,
                    }).toList(),
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            ResponsiveGridView(
              minItemWidth: 200,
              children: filteredDepartments.map((dept) {
                double performanceRatio = (dept["performance"] as double) / (dept["target"] as double);
                Color performanceColor = performanceRatio >= 1.0 ? successColor : 
                    performanceRatio >= 0.8 ? warningColor : dangerColor;

                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: dept["color"],
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: performanceColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${(dept["performance"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                color: performanceColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: disabledOutlineBorderColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (dept["performance"] as double) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: performanceColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${dept["projects"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Active Projects",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
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
                                  "\$${((dept["revenue"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Revenue",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('DepartmentDetailView')
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Activities & Upcoming Tasks
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recent Activities
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "Recent Activities",
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
                          children: recentActivities.take(4).map((activity) {
                            Color statusColor = _getActivityStatusColor(activity["status"]);
                            IconData statusIcon = _getActivityIcon(activity["type"]);

                            return Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: disabledOutlineBorderColor,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(15),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      statusIcon,
                                      color: statusColor,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs,
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
                                          "${activity["description"]}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${activity["user"]} • ${activity["timestamp"].toString().substring(11, 16)}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 10,
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
                      ),
                    ],
                  ),
                ),

                SizedBox(width: spMd),

                // Upcoming Tasks
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "Upcoming Tasks",
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
                          children: upcomingTasks.map((task) {
                            Color priorityColor = task["priority"] == "High" 
                                ? dangerColor 
                                : task["priority"] == "Medium" 
                                    ? warningColor 
                                    : successColor;
                            
                            int daysLeft = DateTime.parse(task["deadline"]).difference(DateTime.now()).inDays;

                            return Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: disabledOutlineBorderColor,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spSm,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${task["title"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
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
                                          color: priorityColor.withAlpha(15),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${task["priority"]}",
                                          style: TextStyle(
                                            color: priorityColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: disabledOutlineBorderColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: (task["progress"] as int) / 100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Text(
                                        "${task["assignee"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${daysLeft} days left",
                                        style: TextStyle(
                                          color: daysLeft <= 2 ? dangerColor : disabledBoldColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    minItemWidth: 200,
                    children: [
                      _buildQuickActionCard(
                        "Create Project",
                        Icons.add_task,
                        primaryColor,
                        () {
                          // navigateTo('CreateProjectView')
                        },
                      ),
                      _buildQuickActionCard(
                        "Add Team Member",
                        Icons.person_add,
                        successColor,
                        () {
                          // navigateTo('AddTeamMemberView')
                        },
                      ),
                      _buildQuickActionCard(
                        "View Reports",
                        Icons.analytics,
                        infoColor,
                        () {
                          // navigateTo('ReportsView')
                        },
                      ),
                      _buildQuickActionCard(
                        "Manage Budget",
                        Icons.account_balance_wallet,
                        warningColor,
                        () {
                          // navigateTo('BudgetManagementView')
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spSm,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: color.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getMetricColor(String colorName) {
    switch (colorName) {
      case "success":
        return successColor;
      case "primary":
        return primaryColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "danger":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  String _formatMetricValue(dynamic value, String unit) {
    switch (unit) {
      case "currency":
        return "\$${((value as int).toDouble()).currency}";
      case "count":
        return "${value}";
      case "percentage":
        return "${(value as num).toStringAsFixed(1)}%";
      case "rating":
        return "${(value as num).toStringAsFixed(1)}/5";
      default:
        return "${value}";
    }
  }

  Color _getActivityStatusColor(String status) {
    switch (status) {
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "error":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case "project_completed":
        return Icons.check_circle;
      case "budget_alert":
        return Icons.warning;
      case "team_update":
        return Icons.people;
      case "revenue_milestone":
        return Icons.trending_up;
      default:
        return Icons.info;
    }
  }
}

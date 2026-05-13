import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaEmployeeManagementView extends StatefulWidget {
  const RhaEmployeeManagementView({super.key});

  @override
  State<RhaEmployeeManagementView> createState() => _RhaEmployeeManagementViewState();
}

class _RhaEmployeeManagementViewState extends State<RhaEmployeeManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "all";
  String selectedRole = "all";
  String selectedStatus = "all";
  bool loading = false;

  List<Map<String, dynamic>> departments = [
    {
      "id": "DEPT001",
      "name": "Engineering",
      "manager": "John Smith",
      "employeeCount": 45,
      "activeAssessments": 12,
      "avgScore": 87.2,
      "color": primaryColor,
    },
    {
      "id": "DEPT002",
      "name": "Sales",
      "manager": "Sarah Johnson",
      "employeeCount": 32,
      "activeAssessments": 8,
      "avgScore": 81.5,
      "color": successColor,
    },
    {
      "id": "DEPT003",
      "name": "Marketing",
      "manager": "Michael Chen",
      "employeeCount": 28,
      "activeAssessments": 6,
      "avgScore": 78.9,
      "color": warningColor,
    },
    {
      "id": "DEPT004",
      "name": "HR",
      "manager": "Emily Rodriguez",
      "employeeCount": 15,
      "activeAssessments": 3,
      "avgScore": 84.3,
      "color": infoColor,
    },
    {
      "id": "DEPT005",
      "name": "Finance",
      "manager": "David Thompson",
      "employeeCount": 22,
      "activeAssessments": 5,
      "avgScore": 82.1,
      "color": dangerColor,
    }
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "type": "assessment_completed",
      "employee": "Sarah Johnson",
      "action": "completed JavaScript Advanced Skills assessment",
      "timestamp": "2024-12-18 14:30:00",
      "score": 94,
    },
    {
      "type": "employee_added",
      "employee": "New Employee",
      "action": "added to Engineering department",
      "timestamp": "2024-12-18 11:15:00",
      "score": null,
    },
    {
      "type": "assessment_failed",
      "employee": "Michael Wilson",
      "action": "failed Data Analysis Skills assessment",
      "timestamp": "2024-12-18 10:45:00",
      "score": 45,
    },
    {
      "type": "department_updated",
      "employee": "System",
      "action": "updated Marketing department settings",
      "timestamp": "2024-12-18 09:30:00",
      "score": null,
    },
    {
      "type": "assessment_started",
      "employee": "Lisa Wang",
      "action": "started Leadership Assessment",
      "timestamp": "2024-12-18 08:20:00",
      "score": null,
    }
  ];

  List<Map<String, dynamic>> managementTools = [
    {
      "title": "Bulk Assessment Assignment",
      "description": "Assign assessments to multiple employees at once",
      "icon": Icons.assignment_add,
      "color": primaryColor,
      "action": "assign_bulk",
    },
    {
      "title": "Department Analytics",
      "description": "View detailed performance analytics by department",
      "icon": Icons.analytics,
      "color": infoColor,
      "action": "analytics",
    },
    {
      "title": "Employee Import",
      "description": "Import employee data from CSV or Excel files",
      "icon": Icons.upload_file,
      "color": successColor,
      "action": "import",
    },
    {
      "title": "Skill Gap Analysis",
      "description": "Identify skill gaps across your organization",
      "icon": Icons.trending_down,
      "color": warningColor,
      "action": "skill_gap",
    },
    {
      "title": "Performance Reports",
      "description": "Generate comprehensive performance reports",
      "icon": Icons.assessment,
      "color": dangerColor,
      "action": "reports",
    },
    {
      "title": "Training Recommendations",
      "description": "AI-powered training suggestions for employees",
      "icon": Icons.school,
      "color": secondaryColor,
      "action": "training",
    }
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "HR", "value": "HR"},
    {"label": "Finance", "value": "Finance"},
  ];

  List<Map<String, dynamic>> roleOptions = [
    {"label": "All Roles", "value": "all"},
    {"label": "Manager", "value": "Manager"},
    {"label": "Senior", "value": "Senior"},
    {"label": "Junior", "value": "Junior"},
    {"label": "Intern", "value": "Intern"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "On Leave", "value": "on_leave"},
    {"label": "Terminated", "value": "terminated"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Employee Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Departments", icon: Icon(Icons.business)),
        Tab(text: "Tools", icon: Icon(Icons.build)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDepartmentsTab(),
        _buildToolsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildQuickStats(),
          _buildSearchAndFilters(),
          _buildRecentActivity(),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Organization Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Employees", "142", Icons.people, primaryColor),
              _buildStatCard("Active Assessments", "34", Icons.assignment, successColor),
              _buildStatCard("Departments", "5", Icons.business, infoColor),
              _buildStatCard("Avg Performance", "83.2%", Icons.trending_up, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
  }

  Widget _buildSearchAndFilters() {
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
              Icon(Icons.search, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Employee Search & Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Search employees by name, ID, or email...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentOptions,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Role",
                  items: roleOptions,
                  value: selectedRole,
                  onChanged: (value, label) {
                    selectedRole = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              QButton(
                label: "Search",
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Export Results",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
              Spacer(),
              QButton(
                label: "Add Employee",
                icon: Icons.person_add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(Icons.history, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...recentActivities.take(5).map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    IconData icon;
    Color color;

    switch (activity["type"]) {
      case "assessment_completed":
        icon = Icons.check_circle;
        color = successColor;
        break;
      case "assessment_failed":
        icon = Icons.error;
        color = dangerColor;
        break;
      case "assessment_started":
        icon = Icons.play_arrow;
        color = primaryColor;
        break;
      case "employee_added":
        icon = Icons.person_add;
        color = infoColor;
        break;
      case "department_updated":
        icon = Icons.business;
        color = warningColor;
        break;
      default:
        icon = Icons.info;
        color = disabledBoldColor;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["employee"]} ${activity["action"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["timestamp"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (activity["score"] != null) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
              decoration: BoxDecoration(
                color: (activity["score"] >= 70 ? successColor : dangerColor).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${activity["score"]}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: activity["score"] >= 70 ? successColor : dangerColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> quickActions = [
      {
        "title": "View All Employees",
        "description": "Browse complete employee directory",
        "icon": Icons.people,
        "color": primaryColor,
      },
      {
        "title": "Assign Assessment",
        "description": "Assign assessment to employees",
        "icon": Icons.assignment_add,
        "color": successColor,
      },
      {
        "title": "Performance Review",
        "description": "Review employee performance data",
        "icon": Icons.analytics,
        "color": infoColor,
      },
      {
        "title": "Department Settings",
        "description": "Manage department configurations",
        "icon": Icons.settings,
        "color": warningColor,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
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
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: quickActions.map((action) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (action["color"] as Color).withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: (action["color"] as Color).withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    action["icon"] as IconData,
                    color: action["color"] as Color,
                    size: 24,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${action["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${action["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Open",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )).toList(),
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
        children: [
          _buildDepartmentOverview(),
          _buildDepartmentsList(),
        ],
      ),
    );
  }

  Widget _buildDepartmentOverview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.business, color: primaryColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Department Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Manage departments, view performance metrics, and track assessments",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Add Department",
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Text(
              "All Departments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...departments.map((dept) => _buildDepartmentItem(dept)),
        ],
      ),
    );
  }

  Widget _buildDepartmentItem(Map<String, dynamic> dept) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: dept["color"] as Color, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${dept["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Manager: ${dept["manager"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: (dept["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Avg: ${(dept["avgScore"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: dept["color"] as Color,
                  ),
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildDeptStat("Employees", "${dept["employeeCount"]}", Icons.people),
              _buildDeptStat("Active Assessments", "${dept["activeAssessments"]}", Icons.assignment),
              _buildDeptStat("Completion Rate", "94.2%", Icons.check_circle),
              _buildDeptStat("Average Score", "${(dept["avgScore"] as double).toStringAsFixed(1)}%", Icons.trending_up),
            ],
          ),
          Row(
            children: [
              QButton(
                label: "View Employees",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Analytics",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Settings",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeptStat(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(icon, color: disabledBoldColor, size: 16),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
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
          ),
        ],
      ),
    );
  }

  Widget _buildToolsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildToolsHeader(),
          _buildManagementTools(),
        ],
      ),
    );
  }

  Widget _buildToolsHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.build, color: primaryColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Management Tools",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Powerful tools to streamline employee management and assessment processes",
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
    );
  }

  Widget _buildManagementTools() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: managementTools.map((tool) => Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border(
            left: BorderSide(color: tool["color"] as Color, width: 4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: (tool["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    tool["icon"] as IconData,
                    color: tool["color"] as Color,
                    size: 24,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: (tool["color"] as Color).withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Tool",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: tool["color"] as Color,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "${tool["title"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${tool["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Open Tool",
                size: bs.sm,
                onPressed: () {},
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

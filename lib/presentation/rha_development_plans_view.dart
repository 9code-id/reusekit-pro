import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaDevelopmentPlansView extends StatefulWidget {
  const RhaDevelopmentPlansView({super.key});

  @override
  State<RhaDevelopmentPlansView> createState() => _RhaDevelopmentPlansViewState();
}

class _RhaDevelopmentPlansViewState extends State<RhaDevelopmentPlansView> {
  int currentTab = 0;
  String selectedPeriod = "2024";
  String selectedStatus = "All";
  String searchQuery = "";
  bool showCompleted = true;

  List<Map<String, dynamic>> developmentPlans = [
    {
      "id": "DP001",
      "employee": "Sarah Johnson",
      "position": "Software Engineer",
      "department": "Engineering",
      "goals": [
        "Complete AWS Certification",
        "Lead cross-functional project",
        "Improve presentation skills"
      ],
      "progress": 75,
      "status": "In Progress",
      "startDate": "2024-01-15",
      "endDate": "2024-12-15",
      "manager": "John Smith",
      "priority": "High",
      "completedGoals": 3,
      "totalGoals": 4,
      "skills": ["Cloud Architecture", "Team Leadership", "Public Speaking"],
      "nextReview": "2024-07-15"
    },
    {
      "id": "DP002",
      "employee": "Michael Chen",
      "position": "Marketing Manager",
      "department": "Marketing",
      "goals": [
        "Digital Marketing Certification",
        "Increase team productivity by 20%",
        "Develop new brand strategy"
      ],
      "progress": 90,
      "status": "Near Completion",
      "startDate": "2024-02-01",
      "endDate": "2024-11-30",
      "manager": "Lisa Wong",
      "priority": "Medium",
      "completedGoals": 2,
      "totalGoals": 3,
      "skills": ["Digital Marketing", "Strategic Planning", "Team Management"],
      "nextReview": "2024-08-01"
    },
    {
      "id": "DP003",
      "employee": "Emily Rodriguez",
      "position": "UX Designer",
      "department": "Design",
      "goals": [
        "Complete UX Research Certification",
        "Mentor junior designers",
        "Redesign mobile app interface"
      ],
      "progress": 45,
      "status": "In Progress",
      "startDate": "2024-03-01",
      "endDate": "2024-12-31",
      "manager": "David Kim",
      "priority": "High",
      "completedGoals": 1,
      "totalGoals": 3,
      "skills": ["User Research", "Mentoring", "Mobile Design"],
      "nextReview": "2024-09-01"
    },
    {
      "id": "DP004",
      "employee": "James Wilson",
      "position": "Sales Representative",
      "department": "Sales",
      "goals": [
        "Achieve 150% of sales target",
        "Complete CRM training",
        "Build client relationship skills"
      ],
      "progress": 100,
      "status": "Completed",
      "startDate": "2024-01-01",
      "endDate": "2024-06-30",
      "manager": "Rachel Green",
      "priority": "Medium",
      "completedGoals": 3,
      "totalGoals": 3,
      "skills": ["Sales Strategy", "CRM Management", "Client Relations"],
      "nextReview": "2024-07-01"
    }
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Near Completion", "value": "Near Completion"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Overdue", "value": "Overdue"}
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "Q4 2024", "value": "Q4 2024"},
    {"label": "Q3 2024", "value": "Q3 2024"}
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return primaryColor;
      case "Near Completion":
        return warningColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.trending_up,
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
                                "Active Plans",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "24",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Completed",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "8",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.schedule,
                            color: warningColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Avg Progress",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "73%",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.warning,
                            color: dangerColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "3",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodItems,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Search
          QTextField(
            label: "Search employees or plans",
            value: searchQuery,
            hint: "Enter employee name or plan ID",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          // Recent Plans
          Container(
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
                  "Recent Development Plans",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...developmentPlans.take(3).map((plan) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: _getStatusColor("${plan["status"]}").withAlpha(20),
                        child: Text(
                          "${plan["employee"]}".split(" ").map((e) => e[0]).join("").toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor("${plan["status"]}"),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${plan["employee"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${plan["position"]} • ${plan["department"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: (plan["progress"] as int) / 100,
                                    backgroundColor: disabledColor,
                                    color: _getStatusColor("${plan["status"]}"),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${plan["progress"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor("${plan["status"]}"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlansTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Create Plan",
                  icon: Icons.add,
                  onPressed: () {
                    ss("Create development plan clicked");
                  },
                ),
              ),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  ss("Filter plans clicked");
                },
              ),
            ],
          ),

          // Plans List
          ...developmentPlans.map((plan) => Container(
            padding: EdgeInsets.all(spMd),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                // Header
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _getStatusColor("${plan["status"]}").withAlpha(20),
                      child: Text(
                        "${plan["employee"]}".split(" ").map((e) => e[0]).join("").toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor("${plan["status"]}"),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${plan["employee"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${plan["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${plan["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor("${plan["status"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${plan["position"]} • ${plan["department"]}",
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

                // Progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progress",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${plan["progress"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor("${plan["status"]}"),
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: (plan["progress"] as int) / 100,
                      backgroundColor: disabledColor,
                      color: _getStatusColor("${plan["status"]}"),
                    ),
                  ],
                ),

                // Goals
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Development Goals",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ...(plan["goals"] as List).take(3).map((goal) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "$goal",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    )).toList(),
                  ],
                ),

                // Skills
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (plan["skills"] as List).map((skill) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Text(
                      "$skill",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),

                // Footer
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Manager: ${plan["manager"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Review: ${DateTime.parse("${plan["nextReview"]}").dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Actions
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          ss("View plan details for ${plan["employee"]}");
                        },
                      ),
                    ),
                    QButton(
                      label: "Update",
                      size: bs.sm,
                      onPressed: () {
                        ss("Update plan for ${plan["employee"]}");
                      },
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Development Plans",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Plans", icon: Icon(Icons.assignment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildPlansTab(),
      ],
    );
  }
}

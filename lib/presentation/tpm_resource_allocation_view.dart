import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmResourceAllocationView extends StatefulWidget {
  const TpmResourceAllocationView({super.key});

  @override
  State<TpmResourceAllocationView> createState() => _TpmResourceAllocationViewState();
}

class _TpmResourceAllocationViewState extends State<TpmResourceAllocationView> {
  int selectedTab = 0;
  String selectedProject = "all";
  String selectedDepartment = "all";
  
  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "E-commerce Platform", "value": "ecommerce"},
    {"label": "Mobile App", "value": "mobile"},
    {"label": "Marketing Campaign", "value": "marketing"},
    {"label": "Website Redesign", "value": "website"},
  ];
  
  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Development", "value": "dev"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
  ];
  
  List<Map<String, dynamic>> resourceSummary = [
    {
      "title": "Total Resources",
      "value": 45,
      "subtitle": "Team Members",
      "icon": Icons.people,
      "color": primaryColor
    },
    {
      "title": "Allocated",
      "value": 38,
      "subtitle": "84% Utilization",
      "icon": Icons.assignment,
      "color": successColor
    },
    {
      "title": "Available",
      "value": 7,
      "subtitle": "16% Available",
      "icon": Icons.schedule,
      "color": warningColor
    },
    {
      "title": "Overallocated",
      "value": 3,
      "subtitle": "Need Attention",
      "icon": Icons.warning,
      "color": dangerColor
    },
  ];
  
  List<Map<String, dynamic>> projectAllocations = [
    {
      "name": "E-commerce Platform",
      "progress": 0.75,
      "totalResources": 12,
      "allocated": 12,
      "budget": 85000.0,
      "spent": 63750.0,
      "priority": "High",
      "deadline": "2024-03-15",
      "status": "On Track",
      "resources": [
        {"name": "Frontend Dev", "count": 4, "utilization": 90},
        {"name": "Backend Dev", "count": 3, "utilization": 95},
        {"name": "Designer", "count": 2, "utilization": 80},
        {"name": "QA Engineer", "count": 2, "utilization": 85},
        {"name": "Project Manager", "count": 1, "utilization": 100},
      ]
    },
    {
      "name": "Mobile App Development",
      "progress": 0.45,
      "totalResources": 8,
      "allocated": 7,
      "budget": 65000.0,
      "spent": 29250.0,
      "priority": "Medium",
      "deadline": "2024-04-20",
      "status": "Behind Schedule",
      "resources": [
        {"name": "Mobile Dev", "count": 3, "utilization": 85},
        {"name": "UI Designer", "count": 2, "utilization": 75},
        {"name": "Backend Dev", "count": 1, "utilization": 90},
        {"name": "QA Engineer", "count": 1, "utilization": 70},
      ]
    },
    {
      "name": "Website Redesign",
      "progress": 0.90,
      "totalResources": 6,
      "allocated": 6,
      "budget": 35000.0,
      "spent": 31500.0,
      "priority": "Low",
      "deadline": "2024-02-28",
      "status": "Almost Complete",
      "resources": [
        {"name": "Designer", "count": 3, "utilization": 95},
        {"name": "Frontend Dev", "count": 2, "utilization": 90},
        {"name": "Content Writer", "count": 1, "utilization": 80},
      ]
    },
  ];
  
  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "Sarah Johnson",
      "role": "Frontend Developer",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
      "utilization": 95,
      "currentProjects": ["E-commerce Platform", "Website Redesign"],
      "skills": ["React", "TypeScript", "CSS"],
      "availability": "Fully Allocated",
      "hourlyRate": 75.0
    },
    {
      "name": "Mike Chen",
      "role": "Backend Developer",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=man",
      "utilization": 90,
      "currentProjects": ["E-commerce Platform", "Mobile App"],
      "skills": ["Node.js", "Python", "AWS"],
      "availability": "Almost Full",
      "hourlyRate": 80.0
    },
    {
      "name": "Emily Davis",
      "role": "UI/UX Designer",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
      "utilization": 75,
      "currentProjects": ["Mobile App", "Website Redesign"],
      "skills": ["Figma", "Adobe XD", "Prototyping"],
      "availability": "Available",
      "hourlyRate": 65.0
    },
    {
      "name": "Alex Rodriguez",
      "role": "Project Manager",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=man",
      "utilization": 100,
      "currentProjects": ["E-commerce Platform"],
      "skills": ["Agile", "Scrum", "Leadership"],
      "availability": "Fully Allocated",
      "hourlyRate": 90.0
    },
    {
      "name": "Lisa Wang",
      "role": "QA Engineer",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=woman",
      "utilization": 60,
      "currentProjects": ["E-commerce Platform"],
      "skills": ["Automation", "Manual Testing", "Selenium"],
      "availability": "Available",
      "hourlyRate": 55.0
    },
  ];
  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Resource Allocation",
      selectedIndex: selectedTab,
      actions: [
        QButton(
          icon: Icons.download,
          size: bs.sm,
          onPressed: () {},
        ),
        SizedBox(width: spXs),
        QButton(
          icon: Icons.settings,
          size: bs.sm,
          onPressed: () {},
        ),
      ],
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Projects", icon: Icon(Icons.work)),
        Tab(text: "Team", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildProjectsTab(),
        _buildTeamTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,        children: [
          _buildFilters(),
          _buildQuickActions(),
          _buildResourceSummary(),
          _buildAllocationChart(),
          _buildCapacityPlanning(),
          _buildRecentAllocations(),
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
          _buildProjectsList(),
        ],
      ),
    );
  }

  Widget _buildTeamTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTeamFilters(),
          _buildTeamMembersList(),
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
              label: "Department",
              items: departments,
              value: selectedDepartment,
              onChanged: (value, label) {
                selectedDepartment = value;
                setState(() {});
              },
            ),
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
              label: "Filter Projects",
              items: projects,
              value: selectedProject,
              onChanged: (value, label) {
                selectedProject = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            label: "Allocate",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTeamFilters() {
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
              label: "Department",
              items: departments,
              value: selectedDepartment,
              onChanged: (value, label) {
                selectedDepartment = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.person_add,
            label: "Add Member",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> quickActions = [
      {
        "title": "Allocate Resources",
        "subtitle": "Assign team members to projects",
        "icon": Icons.assignment_ind,
        "color": primaryColor,
      },
      {
        "title": "View Workload",
        "subtitle": "Check team utilization rates",
        "icon": Icons.work_outline,
        "color": infoColor,
      },
      {
        "title": "Generate Report",
        "subtitle": "Create allocation summary",
        "icon": Icons.assessment,
        "color": successColor,
      },
      {
        "title": "Manage Capacity",
        "subtitle": "Plan future resource needs",
        "icon": Icons.trending_up,
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
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            children: quickActions.map((action) => _buildQuickActionCard(action)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    return GestureDetector(
      onTap: () {
        // Handle quick action tap
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: (action["color"] as Color).withAlpha(5),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: (action["color"] as Color).withAlpha(30)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: (action["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                action["icon"],
                color: action["color"],
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${action["title"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${action["subtitle"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: disabledColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Resource Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: resourceSummary.map((resource) => _buildSummaryCard(resource)).toList(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> resource) {
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
                  color: (resource["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  resource["icon"],
                  color: resource["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${resource["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${resource["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${resource["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildAllocationChart() {
    List<Map<String, dynamic>> chartData = [
      {"label": "Development", "value": 45, "color": primaryColor},
      {"label": "Design", "value": 25, "color": successColor},
      {"label": "Testing", "value": 15, "color": warningColor},
      {"label": "Management", "value": 10, "color": infoColor},
      {"label": "Available", "value": 5, "color": disabledColor},
    ];

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
            "Resource Allocation Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: disabledOutlineBorderColor, width: 20),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "38",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Allocated",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  spacing: spXs,
                  children: chartData.map((data) => _buildChartLegend(data)).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend(Map<String, dynamic> data) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: data["color"],
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            "${data["label"]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
        ),
        Text(
          "${data["value"]}%",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCapacityPlanning() {
    List<Map<String, dynamic>> capacityData = [
      {
        "department": "Development",
        "current": 18,
        "capacity": 20,
        "upcoming": 5,
        "efficiency": 90,
      },
      {
        "department": "Design",
        "current": 8,
        "capacity": 10,
        "upcoming": 3,
        "efficiency": 80,
      },
      {
        "department": "QA",
        "current": 6,
        "capacity": 8,
        "upcoming": 2,
        "efficiency": 75,
      },
      {
        "department": "Management",
        "current": 6,
        "capacity": 7,
        "upcoming": 1,
        "efficiency": 85,
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
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Capacity Planning",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.trending_up,
                label: "Forecast",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...capacityData.map((data) => _buildCapacityItem(data)),
        ],
      ),
    );
  }

  Widget _buildCapacityItem(Map<String, dynamic> data) {
    double utilizationRate = (data["current"] as int) / (data["capacity"] as int);
    Color utilizationColor = utilizationRate >= 0.9 ? dangerColor : 
                           utilizationRate >= 0.7 ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
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
                  "${data["department"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${data["current"]}/${data["capacity"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: utilizationColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: utilizationRate,
                  backgroundColor: disabledOutlineBorderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(utilizationColor),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${(utilizationRate * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: utilizationColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Upcoming: ${data["upcoming"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.speed,
                    size: 14,
                    color: successColor,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Efficiency: ${data["efficiency"]}%",
                    style: TextStyle(
                      fontSize: 11,
                      color: successColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAllocations() {
    List<Map<String, dynamic>> recentAllocations = [
      {"action": "Allocated", "member": "Sarah Johnson", "project": "E-commerce Platform", "hours": 40, "date": "2024-01-15"},
      {"action": "Reallocated", "member": "Mike Chen", "project": "Mobile App", "hours": 30, "date": "2024-01-14"},
      {"action": "Unallocated", "member": "Emily Davis", "project": "Marketing Campaign", "hours": 20, "date": "2024-01-13"},
    ];

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
            "Recent Allocations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recentAllocations.map((allocation) => _buildAllocationItem(allocation)),
        ],
      ),
    );
  }

  Widget _buildAllocationItem(Map<String, dynamic> allocation) {
    Color actionColor = _getActionColor(allocation["action"]);
    
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
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: actionColor,
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
                      "${allocation["action"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: actionColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${allocation["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${allocation["member"]} • ${allocation["project"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${allocation["hours"]} hours/week",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsList() {
    return Column(
      spacing: spSm,
      children: projectAllocations.map((project) => _buildProjectCard(project)).toList(),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    Color statusColor = _getStatusColor(project["status"]);
    Color priorityColor = _getPriorityColor(project["priority"]);
    
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${project["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Deadline: ${project["deadline"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${project["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
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
                      value: project["progress"],
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${((project["progress"] as double) * 100).toInt()}%",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Budget",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${((project["budget"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Spent: \$${((project["spent"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ],
          ),          Row(
            children: [
              Text(
                "Resources: ${project["allocated"]}/${project["totalResources"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Manage",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          if (project["resources"] != null) ...[
            Divider(color: disabledOutlineBorderColor),
            Text(
              "Resource Breakdown",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (project["resources"] as List).map((resource) => _buildResourceChip(resource)).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTeamMembersList() {
    return Column(
      spacing: spSm,
      children: teamMembers.map((member) => _buildTeamMemberCard(member)).toList(),
    );
  }

  Widget _buildTeamMemberCard(Map<String, dynamic> member) {
    Color utilizationColor = _getUtilizationColor(member["utilization"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${member["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${member["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${member["role"]}",
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
                    "${member["utilization"]}%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: utilizationColor,
                    ),
                  ),
                  Text(
                    "${member["availability"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: utilizationColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: disabledOutlineBorderColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (member["utilization"] as int) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: utilizationColor,
                  borderRadius: BorderRadius.circular(radiusXs),
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
                      "Current Projects",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      (member["currentProjects"] as List).join(", "),
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${((member["hourlyRate"] as double)).toStringAsFixed(0)}/hr",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 4,
                  children: (member["skills"] as List).map((skill) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Text(
                      "$skill",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                      ),
                    ),
                  )).toList(),
                ),
              ),
              QButton(
                label: "Allocate",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResourceChip(Map<String, dynamic> resource) {
    Color utilizationColor = _getUtilizationColor(resource["utilization"]);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
      decoration: BoxDecoration(
        color: utilizationColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: utilizationColor.withAlpha(30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${resource["name"]}",
            style: TextStyle(
              fontSize: 10,
              color: utilizationColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4),
          Text(
            "${resource["count"]}",
            style: TextStyle(
              fontSize: 10,
              color: utilizationColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 2),
          Text(
            "(${resource["utilization"]}%)",
            style: TextStyle(
              fontSize: 9,
              color: utilizationColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getActionColor(String action) {
    switch (action.toLowerCase()) {
      case "allocated":
        return successColor;
      case "reallocated":
        return warningColor;
      case "unallocated":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "on track":
      case "almost complete":
        return successColor;
      case "behind schedule":
        return dangerColor;
      case "at risk":
        return warningColor;
      default:
        return infoColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return infoColor;
    }
  }

  Color _getUtilizationColor(int utilization) {
    if (utilization >= 90) return dangerColor;
    if (utilization >= 75) return warningColor;
    return successColor;
  }
}

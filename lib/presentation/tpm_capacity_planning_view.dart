import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmCapacityPlanningView extends StatefulWidget {
  const TpmCapacityPlanningView({super.key});

  @override
  State<TpmCapacityPlanningView> createState() => _TpmCapacityPlanningViewState();
}

class _TpmCapacityPlanningViewState extends State<TpmCapacityPlanningView> {
  int selectedQuarter = 0;
  String selectedDepartment = "all";
  
  List<Map<String, dynamic>> quarters = [
    {"label": "Q1 2024", "value": 0},
    {"label": "Q2 2024", "value": 1},
    {"label": "Q3 2024", "value": 2},
    {"label": "Q4 2024", "value": 3},
  ];
  
  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Development", "value": "dev"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "Operations", "value": "ops"},
  ];
  
  List<Map<String, dynamic>> capacityMetrics = [
    {
      "title": "Current Capacity",
      "value": "1,840",
      "subtitle": "Hours/Week",
      "icon": Icons.schedule,
      "color": primaryColor,
      "trend": 5.2
    },
    {
      "title": "Forecasted Demand",
      "value": "2,150",
      "subtitle": "Hours/Week",
      "icon": Icons.trending_up,
      "color": warningColor,
      "trend": 12.8
    },
    {
      "title": "Capacity Gap",
      "value": "310",
      "subtitle": "Hours Shortage",
      "icon": Icons.warning,
      "color": dangerColor,
      "trend": -15.5
    },
    {
      "title": "Utilization Rate",
      "value": "85.7%",
      "subtitle": "Team Efficiency",
      "icon": Icons.show_chart,
      "color": successColor,
      "trend": 3.1
    },
  ];
  
  List<Map<String, dynamic>> departments_capacity = [
    {
      "name": "Development",
      "current_capacity": 720,
      "forecasted_demand": 850,
      "gap": -130,
      "team_size": 18,
      "utilization": 89.5,
      "skills_needed": ["React", "Node.js", "Python"],
      "hiring_plan": 3
    },
    {
      "name": "Design",
      "current_capacity": 320,
      "forecasted_demand": 380,
      "gap": -60,
      "team_size": 8,
      "utilization": 82.3,
      "skills_needed": ["UI/UX", "Figma", "Adobe Creative"],
      "hiring_plan": 2
    },
    {
      "name": "Marketing",
      "current_capacity": 280,
      "forecasted_demand": 320,
      "gap": -40,
      "team_size": 7,
      "utilization": 78.9,
      "skills_needed": ["Digital Marketing", "Content Creation"],
      "hiring_plan": 1
    },
    {
      "name": "Sales",
      "current_capacity": 360,
      "forecasted_demand": 420,
      "gap": -60,
      "team_size": 9,
      "utilization": 91.2,
      "skills_needed": ["Sales Strategy", "CRM"],
      "hiring_plan": 2
    },
    {
      "name": "Operations",
      "current_capacity": 160,
      "forecasted_demand": 180,
      "gap": -20,
      "team_size": 4,
      "utilization": 95.0,
      "skills_needed": ["Process Management", "Data Analysis"],
      "hiring_plan": 1
    },
  ];
  
  List<Map<String, dynamic>> scenarios = [
    {
      "name": "Conservative Growth",
      "description": "15% increase in project demand",
      "additional_hires": 5,
      "budget_impact": 375000.0,
      "timeline": "6 months",
      "risk_level": "Low",
      "success_probability": 90
    },
    {
      "name": "Moderate Expansion",
      "description": "25% increase in project demand",
      "additional_hires": 9,
      "budget_impact": 675000.0,
      "timeline": "4 months",
      "risk_level": "Medium",
      "success_probability": 75
    },
    {
      "name": "Aggressive Scale",
      "description": "40% increase in project demand",
      "additional_hires": 15,
      "budget_impact": 1125000.0,
      "timeline": "3 months",
      "risk_level": "High",
      "success_probability": 60
    },
  ];
  
  List<Map<String, dynamic>> upcoming_projects = [
    {
      "name": "AI Platform Development",
      "start_date": "2024-03-01",
      "duration_weeks": 16,
      "required_capacity": 480,
      "priority": "High",
      "department": "Development",
      "status": "Planning"
    },
    {
      "name": "Brand Redesign Campaign",
      "start_date": "2024-02-15",
      "duration_weeks": 12,
      "required_capacity": 240,
      "priority": "Medium",
      "department": "Design",
      "status": "Approved"
    },
    {
      "name": "Sales Automation System",
      "start_date": "2024-04-01",
      "duration_weeks": 20,
      "required_capacity": 320,
      "priority": "High",
      "department": "Development",
      "status": "Planning"
    },
    {
      "name": "Market Expansion Strategy",
      "start_date": "2024-03-15",
      "duration_weeks": 8,
      "required_capacity": 160,
      "priority": "Medium",
      "department": "Marketing",
      "status": "Pending"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Capacity Planning"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            _buildCapacityMetrics(),
            _buildCapacityChart(),
            _buildDepartmentCapacity(),
            _buildScenarioPlanning(),
            _buildUpcomingProjects(),
          ],
        ),
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
            child: QCategoryPicker(
              label: "Planning Period",
              items: quarters,
              value: selectedQuarter,
              onChanged: (index, label, value, item) {
                selectedQuarter = value;
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

  Widget _buildCapacityMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Capacity Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: capacityMetrics.map((metric) => _buildMetricCard(metric)).toList(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    bool isPositive = (metric["trend"] as double) >= 0;
    
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
                      "${isPositive ? '+' : ''}${(metric["trend"] as double).toStringAsFixed(1)}%",
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

  Widget _buildCapacityChart() {
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
                "Capacity vs Demand Forecast",
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
                    Icons.bar_chart,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Capacity Forecast Chart",
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

  Widget _buildDepartmentCapacity() {
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
            "Department Capacity Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...departments_capacity.map((dept) => _buildDepartmentCard(dept)),
        ],
      ),
    );
  }

  Widget _buildDepartmentCard(Map<String, dynamic> dept) {
    Color gapColor = (dept["gap"] as int) < 0 ? dangerColor : successColor;
    double utilizationPercent = dept["utilization"] as double;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
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
                      "${dept["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${dept["team_size"]} team members",
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
                    "${utilizationPercent.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getUtilizationColor(utilizationPercent),
                    ),
                  ),
                  Text(
                    "Utilization",
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
                child: _buildCapacityStat("Current", "${dept["current_capacity"]}h", primaryColor),
              ),
              Expanded(
                child: _buildCapacityStat("Demand", "${dept["forecasted_demand"]}h", warningColor),
              ),
              Expanded(
                child: _buildCapacityStat("Gap", "${dept["gap"]}h", gapColor),
              ),
              Expanded(
                child: _buildCapacityStat("Hiring", "+${dept["hiring_plan"]}", successColor),
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
                      "Skills Needed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Wrap(
                      spacing: 4,
                      children: (dept["skills_needed"] as List).map((skill) => Container(
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCapacityStat(String label, String value, Color color) {
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

  Widget _buildScenarioPlanning() {
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
            "Scenario Planning",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...scenarios.map((scenario) => _buildScenarioCard(scenario)),
        ],
      ),
    );
  }

  Widget _buildScenarioCard(Map<String, dynamic> scenario) {
    Color riskColor = _getRiskColor(scenario["risk_level"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
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
                      "${scenario["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${scenario["description"]}",
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
                  color: riskColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${scenario["risk_level"]} Risk",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: riskColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildScenarioStat("Hires", "+${scenario["additional_hires"]}", primaryColor),
              ),
              Expanded(
                child: _buildScenarioStat("Budget", "\$${((scenario["budget_impact"] as double) / 1000).toStringAsFixed(0)}K", warningColor),
              ),
              Expanded(
                child: _buildScenarioStat("Timeline", "${scenario["timeline"]}", infoColor),
              ),
              Expanded(
                child: _buildScenarioStat("Success", "${scenario["success_probability"]}%", successColor),
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              QButton(
                label: "Select Scenario",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
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

  Widget _buildUpcomingProjects() {
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
                "Upcoming Projects Impact",
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
          ...upcoming_projects.map((project) => _buildProjectCard(project)),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    Color priorityColor = _getPriorityColor(project["priority"]);
    Color statusColor = _getStatusColor(project["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
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
                      "${project["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${project["department"]} • ${project["duration_weeks"]} weeks",
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
              Text(
                "Start: ${project["start_date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              Text(
                "Capacity: ${project["required_capacity"]} hours",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getUtilizationColor(double utilization) {
    if (utilization >= 90) return dangerColor;
    if (utilization >= 75) return warningColor;
    return successColor;
  }

  Color _getRiskColor(String risk) {
    switch (risk.toLowerCase()) {
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "approved":
      case "planning":
        return successColor;
      case "pending":
        return warningColor;
      case "on hold":
        return dangerColor;
      default:
        return infoColor;
    }
  }
}

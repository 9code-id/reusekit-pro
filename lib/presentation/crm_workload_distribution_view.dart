import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmWorkloadDistributionView extends StatefulWidget {
  const CrmWorkloadDistributionView({super.key});

  @override
  State<CrmWorkloadDistributionView> createState() => _CrmWorkloadDistributionViewState();
}

class _CrmWorkloadDistributionViewState extends State<CrmWorkloadDistributionView> {
  String selectedTeam = "All Teams";
  String selectedPeriod = "This Week";
  String viewMode = "Agent View";
  
  List<Map<String, dynamic>> teamOptions = [
    {"label": "All Teams", "value": "All Teams"},
    {"label": "Enterprise Sales", "value": "Enterprise Sales"},
    {"label": "SMB Sales", "value": "SMB Sales"},
    {"label": "Customer Support", "value": "Customer Support"},
    {"label": "Marketing", "value": "Marketing"},
  ];
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "Last Week", "value": "Last Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
  ];
  
  List<Map<String, dynamic>> viewModeOptions = [
    {"label": "Agent View", "value": "Agent View"},
    {"label": "Team View", "value": "Team View"},
    {"label": "Task Type View", "value": "Task Type View"},
  ];
  
  List<Map<String, dynamic>> agentWorkloads = [
    {
      "agentId": "AG001",
      "agentName": "Sarah Johnson",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=woman",
      "team": "Enterprise Sales",
      "department": "Sales",
      "totalTasks": 28,
      "completedTasks": 22,
      "pendingTasks": 4,
      "overdueTasks": 2,
      "workloadPercentage": 92.0,
      "efficiency": 87.5,
      "averageTaskTime": 2.5,
      "activeDeals": 8,
      "upcomingDeadlines": 3,
      "workingHours": 42.5,
      "maxCapacity": 45.0,
      "utilization": 94.4,
      "taskBreakdown": {
        "calls": 12,
        "emails": 8,
        "meetings": 5,
        "reports": 3,
      },
      "recentTasks": [
        {"title": "Follow up with TechCorp", "type": "Call", "priority": "High", "dueDate": "2024-12-20"},
        {"title": "Prepare Q4 Report", "type": "Report", "priority": "Medium", "dueDate": "2024-12-22"},
        {"title": "Client Demo Preparation", "type": "Meeting", "priority": "High", "dueDate": "2024-12-21"},
      ],
    },
    {
      "agentId": "AG002",
      "agentName": "Mike Chen",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=man",
      "team": "SMB Sales",
      "department": "Sales",
      "totalTasks": 18,
      "completedTasks": 15,
      "pendingTasks": 2,
      "overdueTasks": 1,
      "workloadPercentage": 75.0,
      "efficiency": 91.2,
      "averageTaskTime": 1.8,
      "activeDeals": 5,
      "upcomingDeadlines": 2,
      "workingHours": 38.0,
      "maxCapacity": 45.0,
      "utilization": 84.4,
      "taskBreakdown": {
        "calls": 8,
        "emails": 6,
        "meetings": 3,
        "reports": 1,
      },
      "recentTasks": [
        {"title": "SMB Client Onboarding", "type": "Call", "priority": "Medium", "dueDate": "2024-12-21"},
        {"title": "Pipeline Review", "type": "Meeting", "priority": "Low", "dueDate": "2024-12-23"},
      ],
    },
    {
      "agentId": "AG003",
      "agentName": "Emily Davis",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=woman",
      "team": "Customer Support",
      "department": "Customer Support",
      "totalTasks": 35,
      "completedTasks": 30,
      "pendingTasks": 3,
      "overdueTasks": 2,
      "workloadPercentage": 98.0,
      "efficiency": 89.7,
      "averageTaskTime": 1.2,
      "activeDeals": 0,
      "upcomingDeadlines": 5,
      "workingHours": 44.0,
      "maxCapacity": 45.0,
      "utilization": 97.8,
      "taskBreakdown": {
        "calls": 18,
        "emails": 12,
        "meetings": 3,
        "reports": 2,
      },
      "recentTasks": [
        {"title": "Customer Issue Resolution", "type": "Call", "priority": "High", "dueDate": "2024-12-20"},
        {"title": "Support Ticket Review", "type": "Email", "priority": "Medium", "dueDate": "2024-12-21"},
        {"title": "Team Standup", "type": "Meeting", "priority": "Low", "dueDate": "2024-12-20"},
      ],
    },
    {
      "agentId": "AG004",
      "agentName": "David Wilson",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=man",
      "team": "Marketing",
      "department": "Marketing",
      "totalTasks": 15,
      "completedTasks": 12,
      "pendingTasks": 3,
      "overdueTasks": 0,
      "workloadPercentage": 65.0,
      "efficiency": 85.0,
      "averageTaskTime": 3.2,
      "activeDeals": 0,
      "upcomingDeadlines": 2,
      "workingHours": 35.0,
      "maxCapacity": 45.0,
      "utilization": 77.8,
      "taskBreakdown": {
        "calls": 2,
        "emails": 5,
        "meetings": 4,
        "reports": 4,
      },
      "recentTasks": [
        {"title": "Campaign Performance Analysis", "type": "Report", "priority": "High", "dueDate": "2024-12-22"},
        {"title": "Content Review Meeting", "type": "Meeting", "priority": "Medium", "dueDate": "2024-12-21"},
      ],
    },
    {
      "agentId": "AG005",
      "agentName": "Jessica Miller",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=woman",
      "team": "SMB Sales",
      "department": "Sales",
      "totalTasks": 12,
      "completedTasks": 8,
      "pendingTasks": 3,
      "overdueTasks": 1,
      "workloadPercentage": 55.0,
      "efficiency": 72.5,
      "averageTaskTime": 2.8,
      "activeDeals": 3,
      "upcomingDeadlines": 4,
      "workingHours": 32.0,
      "maxCapacity": 45.0,
      "utilization": 71.1,
      "taskBreakdown": {
        "calls": 5,
        "emails": 4,
        "meetings": 2,
        "reports": 1,
      },
      "recentTasks": [
        {"title": "New Lead Qualification", "type": "Call", "priority": "Medium", "dueDate": "2024-12-20"},
        {"title": "Weekly Sales Review", "type": "Meeting", "priority": "Low", "dueDate": "2024-12-22"},
      ],
    },
  ];
  
  List<Map<String, dynamic>> teamWorkloads = [
    {
      "teamName": "Enterprise Sales",
      "memberCount": 3,
      "totalTasks": 45,
      "completedTasks": 35,
      "avgWorkload": 88.5,
      "avgEfficiency": 87.0,
      "teamUtilization": 92.1,
      "criticalTasks": 8,
    },
    {
      "teamName": "SMB Sales", 
      "memberCount": 4,
      "totalTasks": 35,
      "completedTasks": 28,
      "avgWorkload": 70.2,
      "avgEfficiency": 85.8,
      "teamUtilization": 82.5,
      "criticalTasks": 3,
    },
    {
      "teamName": "Customer Support",
      "memberCount": 2,
      "totalTasks": 42,
      "completedTasks": 38,
      "avgWorkload": 95.5,
      "avgEfficiency": 91.2,
      "teamUtilization": 95.0,
      "criticalTasks": 12,
    },
    {
      "teamName": "Marketing",
      "memberCount": 2,
      "totalTasks": 25,
      "completedTasks": 20,
      "avgWorkload": 68.0,
      "avgEfficiency": 83.5,
      "teamUtilization": 75.5,
      "criticalTasks": 2,
    },
  ];

  List<Map<String, dynamic>> get filteredWorkloads {
    List<Map<String, dynamic>> filtered = agentWorkloads;
    
    if (selectedTeam != "All Teams") {
      filtered = filtered.where((agent) => agent["team"] == selectedTeam).toList();
    }
    
    return filtered;
  }
  
  Color _getWorkloadColor(double workload) {
    if (workload >= 95) return dangerColor;
    if (workload >= 85) return warningColor;
    if (workload >= 70) return successColor;
    return infoColor;
  }
  
  Color _getEfficiencyColor(double efficiency) {
    if (efficiency >= 90) return successColor;
    if (efficiency >= 75) return warningColor;
    return dangerColor;
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

  @override
  Widget build(BuildContext context) {
    double avgWorkload = filteredWorkloads.isEmpty ? 0.0 : 
      filteredWorkloads.fold(0.0, (sum, item) => sum + (item["workloadPercentage"] as double)) / filteredWorkloads.length;
    double avgEfficiency = filteredWorkloads.isEmpty ? 0.0 : 
      filteredWorkloads.fold(0.0, (sum, item) => sum + (item["efficiency"] as double)) / filteredWorkloads.length;
    int totalTasks = filteredWorkloads.fold(0, (sum, item) => sum + (item["totalTasks"] as int));
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Workload Distribution"),
        actions: [
          QButton(
            icon: Icons.balance,
            size: bs.sm,
            onPressed: () {
              ss("Auto-balance workload feature coming soon");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters Section
            Container(
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
                      Icon(Icons.tune, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Workload Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      QDropdownField(
                        label: "Team",
                        items: teamOptions,
                        value: selectedTeam,
                        onChanged: (value, label) {
                          selectedTeam = value;
                          setState(() {});
                        },
                      ),
                      QDropdownField(
                        label: "Period",
                        items: periodOptions,
                        value: selectedPeriod,
                        onChanged: (value, label) {
                          selectedPeriod = value;
                          setState(() {});
                        },
                      ),
                      QDropdownField(
                        label: "View Mode",
                        items: viewModeOptions,
                        value: viewMode,
                        onChanged: (value, label) {
                          viewMode = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
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
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(Icons.work, color: primaryColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Avg Workload",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${avgWorkload.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
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
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(Icons.speed, color: successColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Avg Efficiency",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${avgEfficiency.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
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
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(Icons.task_alt, color: infoColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Tasks",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$totalTasks",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Main Content based on View Mode
            if (viewMode == "Agent View") _buildAgentView(),
            if (viewMode == "Team View") _buildTeamView(),
            if (viewMode == "Task Type View") _buildTaskTypeView(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAgentView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.person, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Text(
                  "Agent Workload Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredWorkloads.length} agents",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredWorkloads.length,
            itemBuilder: (context, index) {
              final agent = filteredWorkloads[index];
              final workloadColor = _getWorkloadColor(agent["workloadPercentage"] as double);
              final efficiencyColor = _getEfficiencyColor(agent["efficiency"] as double);
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor.withAlpha(100),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    // Agent Header
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${agent["avatar"]}",
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
                                "${agent["agentName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${agent["team"]} • ${agent["department"]}",
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
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: workloadColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${(agent["workloadPercentage"] as double).toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: workloadColor,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Workload",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Workload Metrics
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Tasks",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${agent["totalTasks"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
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
                                      "Completed",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${agent["completedTasks"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
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
                                      "Pending",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${agent["pendingTasks"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
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
                                      "Overdue",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${agent["overdueTasks"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Efficiency",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(agent["efficiency"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: efficiencyColor,
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
                                      "Utilization",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(agent["utilization"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: infoColor,
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
                                      "Avg Task Time",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(agent["averageTaskTime"] as double).toStringAsFixed(1)}h",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
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
                                      "Working Hours",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(agent["workingHours"] as double).toStringAsFixed(1)}h",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                    
                    SizedBox(height: spSm),
                    
                    // Task Breakdown
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Task Breakdown",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTaskBreakdownItem("Calls", (agent["taskBreakdown"]["calls"] as int), successColor),
                              ),
                              Expanded(
                                child: _buildTaskBreakdownItem("Emails", (agent["taskBreakdown"]["emails"] as int), infoColor),
                              ),
                              Expanded(
                                child: _buildTaskBreakdownItem("Meetings", (agent["taskBreakdown"]["meetings"] as int), warningColor),
                              ),
                              Expanded(
                                child: _buildTaskBreakdownItem("Reports", (agent["taskBreakdown"]["reports"] as int), primaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Recent Tasks
                    if ((agent["recentTasks"] as List).isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recent Tasks",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Column(
                              children: (agent["recentTasks"] as List).take(3).map((task) {
                                final priorityColor = _getPriorityColor(task["priority"]);
                                
                                return Container(
                                  margin: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 4,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: priorityColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${task["title"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "${task["type"]} • Due: ${task["dueDate"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: priorityColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${task["priority"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: priorityColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildTeamView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.groups, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Text(
                  "Team Workload Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: teamWorkloads.length,
            itemBuilder: (context, index) {
              final team = teamWorkloads[index];
              final workloadColor = _getWorkloadColor(team["avgWorkload"] as double);
              final efficiencyColor = _getEfficiencyColor(team["avgEfficiency"] as double);
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor.withAlpha(100),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: workloadColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(Icons.groups, color: workloadColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${team["teamName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${team["memberCount"]} members • ${team["criticalTasks"]} critical tasks",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: workloadColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${(team["avgWorkload"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: workloadColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Tasks",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${team["totalTasks"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
                                  "Completed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${team["completedTasks"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
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
                                  "Efficiency",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(team["avgEfficiency"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: efficiencyColor,
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
                                  "Utilization",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(team["teamUtilization"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildTaskTypeView() {
    Map<String, int> taskTypeTotals = {
      "Calls": 0,
      "Emails": 0,
      "Meetings": 0,
      "Reports": 0,
    };
    
    for (var agent in filteredWorkloads) {
      final breakdown = agent["taskBreakdown"] as Map<String, dynamic>;
      taskTypeTotals["Calls"] = (taskTypeTotals["Calls"]!) + (breakdown["calls"] as int);
      taskTypeTotals["Emails"] = (taskTypeTotals["Emails"]!) + (breakdown["emails"] as int);
      taskTypeTotals["Meetings"] = (taskTypeTotals["Meetings"]!) + (breakdown["meetings"] as int);
      taskTypeTotals["Reports"] = (taskTypeTotals["Reports"]!) + (breakdown["reports"] as int);
    }
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.category, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Text(
                  "Task Type Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            child: ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildTaskTypeCard("Calls", taskTypeTotals["Calls"]!, successColor, Icons.phone),
                _buildTaskTypeCard("Emails", taskTypeTotals["Emails"]!, infoColor, Icons.email),
                _buildTaskTypeCard("Meetings", taskTypeTotals["Meetings"]!, warningColor, Icons.video_call),
                _buildTaskTypeCard("Reports", taskTypeTotals["Reports"]!, primaryColor, Icons.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTaskBreakdownItem(String label, int count, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "$count",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
  
  Widget _buildTaskTypeCard(String title, int count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            "tasks",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmTeamAssignmentsView extends StatefulWidget {
  const CrmTeamAssignmentsView({super.key});

  @override
  State<CrmTeamAssignmentsView> createState() => _CrmTeamAssignmentsViewState();
}

class _CrmTeamAssignmentsViewState extends State<CrmTeamAssignmentsView> {
  String selectedTeam = "All Teams";
  String selectedStatus = "All Status";
  String searchQuery = "";
  
  List<Map<String, dynamic>> teamOptions = [
    {"label": "All Teams", "value": "All Teams"},
    {"label": "Enterprise Sales Team", "value": "Enterprise Sales Team"},
    {"label": "SMB Sales Team", "value": "SMB Sales Team"},
    {"label": "Customer Success Team", "value": "Customer Success Team"},
    {"label": "Digital Marketing Team", "value": "Digital Marketing Team"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Overdue", "value": "Overdue"},
  ];
  
  List<Map<String, dynamic>> assignments = [
    {
      "id": "ASG001",
      "title": "Q4 Enterprise Lead Generation Campaign",
      "description": "Focus on Fortune 500 companies for enterprise software solutions",
      "teamName": "Enterprise Sales Team",
      "assignedTo": [
        {
          "name": "Sarah Johnson",
          "role": "Lead Agent",
          "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
          "progress": 85.0,
        },
        {
          "name": "Mike Chen",
          "role": "Support Agent",
          "avatar": "https://picsum.photos/40/40?random=2&keyword=man",
          "progress": 72.0,
        },
        {
          "name": "David Wilson",
          "role": "Research Agent",
          "avatar": "https://picsum.photos/40/40?random=3&keyword=man",
          "progress": 91.0,
        },
      ],
      "manager": "Alex Rodriguez",
      "priority": "High",
      "status": "Active",
      "startDate": "2024-10-01",
      "dueDate": "2024-12-31",
      "completionDate": "",
      "progress": 82.0,
      "targetRevenue": 500000.0,
      "currentRevenue": 420000.0,
      "leadsTarget": 100,
      "leadsGenerated": 78,
      "category": "Lead Generation",
      "tags": ["Enterprise", "B2B", "Software"],
    },
    {
      "id": "ASG002",
      "title": "SMB Customer Onboarding Optimization",
      "description": "Improve onboarding process for small and medium business clients",
      "teamName": "SMB Sales Team",
      "assignedTo": [
        {
          "name": "Emily Davis",
          "role": "Lead Agent",
          "avatar": "https://picsum.photos/40/40?random=4&keyword=woman",
          "progress": 95.0,
        },
        {
          "name": "Jessica Miller",
          "role": "Support Agent",
          "avatar": "https://picsum.photos/40/40?random=5&keyword=woman",
          "progress": 68.0,
        },
      ],
      "manager": "Sarah Johnson",
      "priority": "Medium",
      "status": "Active",
      "startDate": "2024-11-15",
      "dueDate": "2025-01-15",
      "completionDate": "",
      "progress": 75.0,
      "targetRevenue": 200000.0,
      "currentRevenue": 145000.0,
      "leadsTarget": 50,
      "leadsGenerated": 42,
      "category": "Customer Onboarding",
      "tags": ["SMB", "Onboarding", "Process"],
    },
    {
      "id": "ASG003",
      "title": "Customer Retention Strategy Implementation",
      "description": "Execute comprehensive retention strategy for existing customer base",
      "teamName": "Customer Success Team",
      "assignedTo": [
        {
          "name": "Lisa Wang",
          "role": "Lead Agent",
          "avatar": "https://picsum.photos/40/40?random=6&keyword=woman",
          "progress": 88.0,
        },
        {
          "name": "Chris Brown",
          "role": "Support Agent",
          "avatar": "https://picsum.photos/40/40?random=7&keyword=man",
          "progress": 82.0,
        },
        {
          "name": "Anna Taylor",
          "role": "Analyst",
          "avatar": "https://picsum.photos/40/40?random=8&keyword=woman",
          "progress": 76.0,
        },
      ],
      "manager": "Robert Kim",
      "priority": "High",
      "status": "Completed",
      "startDate": "2024-09-01",
      "dueDate": "2024-11-30",
      "completionDate": "2024-11-28",
      "progress": 100.0,
      "targetRevenue": 0.0,
      "currentRevenue": 0.0,
      "leadsTarget": 0,
      "leadsGenerated": 0,
      "category": "Customer Success",
      "tags": ["Retention", "Customer Success", "Strategy"],
    },
    {
      "id": "ASG004",
      "title": "Digital Marketing Campaign - Holiday Season",
      "description": "Launch multi-channel marketing campaign for holiday season promotions",
      "teamName": "Digital Marketing Team",
      "assignedTo": [
        {
          "name": "Kevin Park",
          "role": "Campaign Manager",
          "avatar": "https://picsum.photos/40/40?random=9&keyword=man",
          "progress": 45.0,
        },
        {
          "name": "Sofia Garcia",
          "role": "Creative Lead",
          "avatar": "https://picsum.photos/40/40?random=10&keyword=woman",
          "progress": 52.0,
        },
      ],
      "manager": "Marketing Director",
      "priority": "High",
      "status": "Pending",
      "startDate": "2024-12-20",
      "dueDate": "2025-01-31",
      "completionDate": "",
      "progress": 15.0,
      "targetRevenue": 300000.0,
      "currentRevenue": 25000.0,
      "leadsTarget": 200,
      "leadsGenerated": 28,
      "category": "Marketing Campaign",
      "tags": ["Holiday", "Multi-channel", "Promotion"],
    },
    {
      "id": "ASG005",
      "title": "Product Demo Training Program",
      "description": "Comprehensive training program for new product demo techniques",
      "teamName": "Enterprise Sales Team",
      "assignedTo": [
        {
          "name": "Tom Anderson",
          "role": "Trainer",
          "avatar": "https://picsum.photos/40/40?random=11&keyword=man",
          "progress": 30.0,
        },
        {
          "name": "Sarah Johnson",
          "role": "Trainee",
          "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
          "progress": 65.0,
        },
      ],
      "manager": "Alex Rodriguez",
      "priority": "Low",
      "status": "Overdue",
      "startDate": "2024-11-01",
      "dueDate": "2024-12-15",
      "completionDate": "",
      "progress": 40.0,
      "targetRevenue": 0.0,
      "currentRevenue": 0.0,
      "leadsTarget": 0,
      "leadsGenerated": 0,
      "category": "Training",
      "tags": ["Training", "Product Demo", "Skills"],
    },
  ];

  List<Map<String, dynamic>> get filteredAssignments {
    List<Map<String, dynamic>> filtered = assignments;
    
    if (selectedTeam != "All Teams") {
      filtered = filtered.where((assignment) => assignment["teamName"] == selectedTeam).toList();
    }
    
    if (selectedStatus != "All Status") {
      filtered = filtered.where((assignment) => assignment["status"] == selectedStatus).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((assignment) =>
        (assignment["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (assignment["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (assignment["category"] as String).toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    return filtered;
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Completed":
        return infoColor;
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
  
  Color _getProgressColor(double progress) {
    if (progress >= 80) return successColor;
    if (progress >= 50) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    int activeAssignments = filteredAssignments.where((assignment) => assignment["status"] == "Active").length;
    int completedAssignments = filteredAssignments.where((assignment) => assignment["status"] == "Completed").length;
    double avgProgress = filteredAssignments.isEmpty ? 0.0 : 
      filteredAssignments.fold(0.0, (sum, item) => sum + (item["progress"] as double)) / filteredAssignments.length;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Assignments"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              ss("Create new assignment feature coming soon");
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
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Assignment Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Search Assignments",
                    value: searchQuery,
                    hint: "Search by title, description, or category",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Team",
                          items: teamOptions,
                          value: selectedTeam,
                          onChanged: (value, label) {
                            selectedTeam = value;
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
                            child: Icon(Icons.assignment, color: primaryColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Assignments",
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
                        "${filteredAssignments.length}",
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
                            child: Icon(Icons.task_alt, color: successColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Active",
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
                        "$activeAssignments",
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
                            child: Icon(Icons.trending_up, color: infoColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Avg Progress",
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
                        "${avgProgress.toStringAsFixed(1)}%",
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
            
            // Assignments List
            Container(
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
                        Icon(Icons.assignment, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Team Assignments",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredAssignments.length} assignments",
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
                    itemCount: filteredAssignments.length,
                    itemBuilder: (context, index) {
                      final assignment = filteredAssignments[index];
                      final statusColor = _getStatusColor(assignment["status"]);
                      final priorityColor = _getPriorityColor(assignment["priority"]);
                      final progressColor = _getProgressColor(assignment["progress"] as double);
                      final hasRevenue = (assignment["targetRevenue"] as double) > 0;
                      
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
                            // Assignment Header
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(Icons.assignment, color: statusColor, size: 20),
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
                                              "${assignment["title"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: priorityColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${assignment["priority"]}",
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
                                              "${assignment["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: statusColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${assignment["description"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "Team: ${assignment["teamName"]} • Manager: ${assignment["manager"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Progress Bar and Dates
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
                                      Text(
                                        "Progress: ${(assignment["progress"] as double).toStringAsFixed(0)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: progressColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Due: ${assignment["dueDate"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    width: double.infinity,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      widthFactor: ((assignment["progress"] as double) / 100).clamp(0.0, 1.0),
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: progressColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Revenue and Leads (if applicable)
                            if (hasRevenue) ...[
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Target Revenue",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${(assignment["targetRevenue"] as double).currency}",
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
                                            "Current Revenue",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${(assignment["currentRevenue"] as double).currency}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: successColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if ((assignment["leadsTarget"] as int) > 0)
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Leads Progress",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${assignment["leadsGenerated"]}/${assignment["leadsTarget"]}",
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
                              SizedBox(height: spSm),
                            ],
                            
                            // Team Members
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Assigned Team Members",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${(assignment["assignedTo"] as List).length} members",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Column(
                                    children: (assignment["assignedTo"] as List).map((member) {
                                      final memberProgressColor = _getProgressColor(member["progress"] as double);
                                      
                                      return Container(
                                        margin: EdgeInsets.only(bottom: spXs),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(radiusSm),
                                              child: Image.network(
                                                "${member["avatar"]}",
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${member["name"]}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: primaryColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${member["role"]}",
                                                    style: TextStyle(
                                                      fontSize: 10,
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
                                                  "${(member["progress"] as double).toStringAsFixed(0)}%",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: memberProgressColor,
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: 4,
                                                  margin: EdgeInsets.only(top: 2),
                                                  decoration: BoxDecoration(
                                                    color: disabledColor,
                                                    borderRadius: BorderRadius.circular(radiusXs),
                                                  ),
                                                  child: FractionallySizedBox(
                                                    widthFactor: ((member["progress"] as double) / 100).clamp(0.0, 1.0),
                                                    alignment: Alignment.centerLeft,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: memberProgressColor,
                                                        borderRadius: BorderRadius.circular(radiusXs),
                                                      ),
                                                    ),
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
                            
                            // Tags
                            if ((assignment["tags"] as List).isNotEmpty) ...[
                              SizedBox(height: spSm),
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (assignment["tags"] as List).map((tag) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$tag",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: infoColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                            
                            // Action Buttons
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Opening ${assignment["title"]} details");
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.edit,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Edit assignment");
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Assignment options");
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

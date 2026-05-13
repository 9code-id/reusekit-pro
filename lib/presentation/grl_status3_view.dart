import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStatus3View extends StatefulWidget {
  @override
  State<GrlStatus3View> createState() => _GrlStatus3ViewState();
}

class _GrlStatus3ViewState extends State<GrlStatus3View> {
  String selectedDepartment = "All";
  String selectedStatus = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
    {"label": "HR", "value": "HR"},
    {"label": "Finance", "value": "Finance"},
  ];

  List<Map<String, dynamic>> statusTypes = [
    {"label": "All Status", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "On Leave", "value": "On Leave"},
    {"label": "Remote", "value": "Remote"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> projects = [
    {
      "id": "PRJ001",
      "name": "Mobile App Development",
      "description": "Flutter mobile application for customer management",
      "department": "Engineering",
      "status": "Active",
      "priority": "High",
      "progress": 75,
      "startDate": "2024-01-15",
      "endDate": "2024-06-30",
      "teamLead": "John Smith",
      "teamSize": 8,
      "budget": 150000,
      "spent": 112500,
      "tags": ["Mobile", "Flutter", "Customer"],
      "completedTasks": 45,
      "totalTasks": 60,
    },
    {
      "id": "PRJ002", 
      "name": "Marketing Campaign Q2",
      "description": "Digital marketing campaign for product launch",
      "department": "Marketing",
      "status": "Active",
      "priority": "Medium",
      "progress": 60,
      "startDate": "2024-03-01",
      "endDate": "2024-06-15",
      "teamLead": "Sarah Johnson",
      "teamSize": 5,
      "budget": 80000,
      "spent": 48000,
      "tags": ["Digital", "Campaign", "Launch"],
      "completedTasks": 18,
      "totalTasks": 30,
    },
    {
      "id": "PRJ003",
      "name": "Sales Process Optimization",
      "description": "Streamline sales workflow and CRM integration",
      "department": "Sales",
      "status": "On Leave",
      "priority": "High",
      "progress": 40,
      "startDate": "2024-02-01",
      "endDate": "2024-08-31",
      "teamLead": "Mike Wilson",
      "teamSize": 6,
      "budget": 120000,
      "spent": 48000,
      "tags": ["CRM", "Workflow", "Optimization"],
      "completedTasks": 12,
      "totalTasks": 30,
    },
    {
      "id": "PRJ004",
      "name": "HR Management System",
      "description": "Internal HR system for employee management",
      "department": "HR",
      "status": "Remote",
      "priority": "Medium",
      "progress": 85,
      "startDate": "2023-10-01",
      "endDate": "2024-05-31",
      "teamLead": "Emily Chen",
      "teamSize": 4,
      "budget": 90000,
      "spent": 76500,
      "tags": ["HR", "Internal", "Management"],
      "completedTasks": 34,
      "totalTasks": 40,
    },
    {
      "id": "PRJ005",
      "name": "Financial Reporting Tool",
      "description": "Automated financial reporting and analytics",
      "department": "Finance",
      "status": "Inactive",
      "priority": "Low",
      "progress": 25,
      "startDate": "2024-01-01",
      "endDate": "2024-12-31",
      "teamLead": "David Brown",
      "teamSize": 3,
      "budget": 60000,
      "spent": 15000,
      "tags": ["Finance", "Reporting", "Analytics"],
      "completedTasks": 5,
      "totalTasks": 20,
    },
    {
      "id": "PRJ006",
      "name": "Customer Support Portal",
      "description": "Self-service portal for customer support",
      "department": "Engineering",
      "status": "Active",
      "priority": "High",
      "progress": 90,
      "startDate": "2023-11-01", 
      "endDate": "2024-04-30",
      "teamLead": "Lisa Wang",
      "teamSize": 7,
      "budget": 110000,
      "spent": 99000,
      "tags": ["Support", "Portal", "Self-service"],
      "completedTasks": 27,
      "totalTasks": 30,
    },
  ];

  List<Map<String, dynamic>> get filteredProjects {
    return projects.where((project) {
      bool matchesDepartment = selectedDepartment == "All" || 
          "${project["department"]}" == selectedDepartment;
      bool matchesStatus = selectedStatus == "All" || 
          "${project["status"]}" == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty ||
          "${project["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${project["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${project["teamLead"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesDepartment && matchesStatus && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "On Leave":
        return warningColor;
      case "Remote":
        return infoColor;
      case "Inactive":
        return disabledBoldColor;
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

  Widget _buildProjectCard(Map<String, dynamic> project) {
    double progressValue = (project["progress"] as num) / 100;
    double budgetUsed = ((project["spent"] as num) / (project["budget"] as num)) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: _getStatusColor("${project["status"]}").withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${project["id"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getPriorityColor("${project["priority"]}"),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${project["priority"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${project["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${project["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                    color: _getStatusColor("${project["status"]}"),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${project["status"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: progressValue,
                                  backgroundColor: disabledColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    progressValue > 0.8 ? successColor :
                                    progressValue > 0.5 ? warningColor : dangerColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(project["progress"] as num).toInt()}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Tasks",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${project["completedTasks"]}/${project["totalTasks"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${project["teamLead"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.group,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${project["teamSize"]} members",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${((project["spent"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${project["startDate"]} - ${project["endDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${budgetUsed.toStringAsFixed(1)}% budget used",
                      style: TextStyle(
                        fontSize: 12,
                        color: budgetUsed > 80 ? dangerColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  runSpacing: 4,
                  children: (project["tags"] as List).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              Spacer(),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtered = filteredProjects;
    int activeProjects = filtered.where((p) => "${p["status"]}" == "Active").length;
    int onLeaveProjects = filtered.where((p) => "${p["status"]}" == "On Leave").length;
    int remoteProjects = filtered.where((p) => "${p["status"]}" == "Remote").length;
    double avgProgress = filtered.isEmpty ? 0 : 
        filtered.map((p) => p["progress"] as num).reduce((a, b) => a + b) / filtered.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Project Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildSummaryCard(
                  "Active Projects",
                  "$activeProjects",
                  "ONGOING",
                  successColor,
                  Icons.play_circle_filled,
                ),
                _buildSummaryCard(
                  "On Leave",
                  "$onLeaveProjects", 
                  "PAUSED",
                  warningColor,
                  Icons.pause_circle_filled,
                ),
                _buildSummaryCard(
                  "Remote Work",
                  "$remoteProjects",
                  "DISTRIBUTED",
                  infoColor,
                  Icons.cloud,
                ),
                _buildSummaryCard(
                  "Avg Progress",
                  "${avgProgress.toStringAsFixed(1)}%",
                  "COMPLETION",
                  primaryColor,
                  Icons.trending_up,
                ),
              ],
            ),
            SizedBox(height: spLg),
            Row(
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
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusTypes,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Search Projects",
              value: searchQuery,
              hint: "Search by name, ID, or team lead...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            Row(
              children: [
                Text(
                  "Projects (${filtered.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Add Project",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spMd),
            if (filtered.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_open,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No projects found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or search terms",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ...filtered.map((project) => _buildProjectCard(project)).toList(),
          ],
        ),
      ),
    );
  }
}

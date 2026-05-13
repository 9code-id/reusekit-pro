import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsProjectManagementView extends StatefulWidget {
  const DmsProjectManagementView({super.key});

  @override
  State<DmsProjectManagementView> createState() => _DmsProjectManagementViewState();
}

class _DmsProjectManagementViewState extends State<DmsProjectManagementView> {
  String selectedStatus = "all";
  String selectedPriority = "all";
  String searchQuery = "";
  bool loading = false;
  int selectedView = 0; // 0: List, 1: Kanban, 2: Calendar

  List<Map<String, dynamic>> projects = [
    {
      "id": 1,
      "name": "E-commerce Platform",
      "client": "TechCorp Solutions",
      "status": "in_progress",
      "priority": "high",
      "progress": 75,
      "startDate": "2024-04-15",
      "endDate": "2024-07-30",
      "budget": 125000,
      "spent": 93750,
      "teamSize": 6,
      "manager": "Alice Johnson",
      "description": "Development of a comprehensive e-commerce platform with advanced features",
      "tags": ["Web Development", "React", "Node.js"],
      "avatar": "https://picsum.photos/100/100?random=1&keyword=ecommerce",
    },
    {
      "id": 2,
      "name": "Mobile Banking App",
      "client": "Enterprise Corp",
      "status": "planning",
      "priority": "high",
      "progress": 15,
      "startDate": "2024-06-01",
      "endDate": "2024-12-15",
      "budget": 250000,
      "spent": 37500,
      "teamSize": 8,
      "manager": "Bob Wilson",
      "description": "Secure mobile banking application with biometric authentication",
      "tags": ["Mobile", "Flutter", "Security"],
      "avatar": "https://picsum.photos/100/100?random=2&keyword=banking",
    },
    {
      "id": 3,
      "name": "Marketing Dashboard",
      "client": "Global Marketing Inc",
      "status": "completed",
      "priority": "medium",
      "progress": 100,
      "startDate": "2024-02-01",
      "endDate": "2024-05-30",
      "budget": 78000,
      "spent": 75600,
      "teamSize": 4,
      "manager": "Carol Smith",
      "description": "Analytics dashboard for marketing campaign performance tracking",
      "tags": ["Dashboard", "Analytics", "Vue.js"],
      "avatar": "https://picsum.photos/100/100?random=3&keyword=dashboard",
    },
    {
      "id": 4,
      "name": "Website Redesign",
      "client": "StartupXYZ",
      "status": "on_hold",
      "priority": "low",
      "progress": 45,
      "startDate": "2024-03-01",
      "endDate": "2024-08-15",
      "budget": 25000,
      "spent": 11250,
      "teamSize": 3,
      "manager": "David Brown",
      "description": "Complete website redesign with modern UI/UX",
      "tags": ["Design", "WordPress", "SEO"],
      "avatar": "https://picsum.photos/100/100?random=4&keyword=website",
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "id": 1,
      "projectId": 1,
      "type": "milestone",
      "title": "Frontend Development Complete",
      "description": "All frontend components have been completed and tested",
      "timestamp": "2024-06-19 14:30",
      "user": "Alice Johnson",
    },
    {
      "id": 2,
      "projectId": 2,
      "type": "task",
      "title": "Security Audit Scheduled",
      "description": "Third-party security audit has been scheduled for next week",
      "timestamp": "2024-06-19 11:15",
      "user": "Bob Wilson",
    },
    {
      "id": 3,
      "projectId": 1,
      "type": "comment",
      "title": "Client Feedback Received",
      "description": "Client provided feedback on the latest prototype",
      "timestamp": "2024-06-18 16:45",
      "user": "TechCorp Solutions",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _createNewProject(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProjectStats(),
                  SizedBox(height: spLg),
                  _buildViewSelector(),
                  SizedBox(height: spLg),
                  _buildFiltersAndSearch(),
                  SizedBox(height: spLg),
                  _buildProjectsView(),
                  SizedBox(height: spLg),
                  _buildRecentActivities(),
                ],
              ),
            ),
    );
  }

  Widget _buildProjectStats() {
    final totalProjects = projects.length;
    final activeProjects = projects.where((p) => p["status"] == "in_progress").length;
    final completedProjects = projects.where((p) => p["status"] == "completed").length;
    final totalBudget = projects.fold<num>(0, (sum, project) => sum + (project["budget"] as num));

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Project Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildStatCard("Total", "$totalProjects", Icons.work, primaryColor),
              SizedBox(width: spSm),
              _buildStatCard("Active", "$activeProjects", Icons.play_circle, warningColor),
              SizedBox(width: spSm),
              _buildStatCard("Completed", "$completedProjects", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildStatCard("Budget", "\$${(totalBudget / 1000).toStringAsFixed(0)}K", Icons.attach_money, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Text(
            "View:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          _buildViewButton("List", Icons.list, 0),
          SizedBox(width: spXs),
          _buildViewButton("Kanban", Icons.view_column, 1),
          SizedBox(width: spXs),
          _buildViewButton("Calendar", Icons.calendar_month, 2),
        ],
      ),
    );
  }

  Widget _buildViewButton(String label, IconData icon, int index) {
    final isSelected = selectedView == index;
    return GestureDetector(
      onTap: () {
        selectedView = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusXs),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? primaryColor : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersAndSearch() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "Search projects...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All", "value": "all"},
                    {"label": "Planning", "value": "planning"},
                    {"label": "In Progress", "value": "in_progress"},
                    {"label": "On Hold", "value": "on_hold"},
                    {"label": "Completed", "value": "completed"},
                  ],
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
          QCategoryPicker(
            items: [
              {"label": "All Priority", "value": "all"},
              {"label": "High", "value": "high"},
              {"label": "Medium", "value": "medium"},
              {"label": "Low", "value": "low"},
            ],
            value: selectedPriority,
            onChanged: (index, label, value, item) {
              selectedPriority = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsView() {
    final filteredProjects = _getFilteredProjects();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Projects (${filteredProjects.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          if (selectedView == 0) _buildListView(filteredProjects),
          if (selectedView == 1) _buildKanbanView(filteredProjects),
          if (selectedView == 2) _buildCalendarView(filteredProjects),
        ],
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> projects) {
    return Column(
      children: projects.map((project) => _buildProjectCard(project)).toList(),
    );
  }

  Widget _buildKanbanView(List<Map<String, dynamic>> projects) {
    final statuses = ["planning", "in_progress", "on_hold", "completed"];
    
    return Container(
      height: 400,
      child: QHorizontalScroll(
        children: statuses.map((status) {
          final statusProjects = projects.where((p) => p["status"] == status).toList();
          return Container(
            width: 280,
            margin: EdgeInsets.only(right: spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _getStatusLabel(status),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(status),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${statusProjects.length}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: statusProjects.map((project) => 
                        Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          child: _buildKanbanCard(project),
                        )
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendarView(List<Map<String, dynamic>> projects) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month,
              size: 48,
              color: primaryColor.withAlpha(50),
            ),
            SizedBox(height: spSm),
            Text(
              "Calendar View",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Project timeline and milestones",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${project["avatar"]}"),
                    fit: BoxFit.cover,
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
                        Text(
                          "${project["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        _buildStatusBadge(project["status"]),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${project["client"]} • ${project["manager"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              _buildPriorityBadge(project["priority"]),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${project["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress: ${project["progress"]}%",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: (project["progress"] as num) / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getStatusColor(project["status"]),
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
                    "\$${((project["budget"] as num) / 1000).toStringAsFixed(0)}K",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "${project["teamSize"]} members",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: spXs,
                children: (project["tags"] as List).take(2).map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        fontSize: 8,
                        color: primaryColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
              QButton(
                icon: Icons.arrow_forward,
                size: bs.sm,
                onPressed: () => _viewProjectDetails(project),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanCard(Map<String, dynamic> project) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
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
          SizedBox(height: spXs),
          Text(
            "${project["client"]}",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPriorityBadge(project["priority"]),
              Text(
                "${project["progress"]}%",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(project["status"]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        _getStatusLabel(status).toUpperCase(),
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: _getStatusColor(status),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color;
    switch (priority) {
      case "high":
        color = dangerColor;
        break;
      case "medium":
        color = warningColor;
        break;
      default:
        color = successColor;
    }

    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...recentActivities.map((activity) => _buildActivityItem(activity)).toList(),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    IconData icon;
    Color iconColor;

    switch (activity["type"]) {
      case "milestone":
        icon = Icons.flag;
        iconColor = successColor;
        break;
      case "task":
        icon = Icons.task;
        iconColor = primaryColor;
        break;
      case "comment":
        icon = Icons.comment;
        iconColor = infoColor;
        break;
      default:
        icon = Icons.info;
        iconColor = disabledBoldColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${activity["user"]} • ${activity["timestamp"]}",
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "planning":
        return infoColor;
      case "in_progress":
        return warningColor;
      case "on_hold":
        return dangerColor;
      case "completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "planning":
        return "Planning";
      case "in_progress":
        return "In Progress";
      case "on_hold":
        return "On Hold";
      case "completed":
        return "Completed";
      default:
        return status;
    }
  }

  List<Map<String, dynamic>> _getFilteredProjects() {
    return projects.where((project) {
      final matchesSearch = searchQuery.isEmpty ||
          project["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          project["client"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          project["manager"].toString().toLowerCase().contains(searchQuery.toLowerCase());

      final matchesStatus = selectedStatus == "all" ||
          project["status"] == selectedStatus;

      final matchesPriority = selectedPriority == "all" ||
          project["priority"] == selectedPriority;

      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  void _createNewProject() {
    // navigateTo('CreateProjectView')
  }

  void _viewProjectDetails(Map<String, dynamic> project) {
    // navigateTo('ProjectDetailsView')
  }
}

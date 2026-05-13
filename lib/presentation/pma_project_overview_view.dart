import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaProjectOverviewView extends StatefulWidget {
  const PmaProjectOverviewView({super.key});

  @override
  State<PmaProjectOverviewView> createState() => _PmaProjectOverviewViewState();
}

class _PmaProjectOverviewViewState extends State<PmaProjectOverviewView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedPriority = "";
  
  List<Map<String, dynamic>> projects = [
    {
      "id": 1,
      "name": "E-commerce Platform",
      "description": "Development of a modern e-commerce platform with advanced features",
      "status": "In Progress",
      "priority": "High",
      "progress": 75,
      "startDate": "2024-01-15",
      "endDate": "2024-06-30",
      "budget": 50000.0,
      "spent": 37500.0,
      "teamSize": 8,
      "manager": "Sarah Wilson",
      "color": Colors.blue,
      "completedTasks": 45,
      "totalTasks": 60,
      "issues": 3,
      "milestones": 4,
      "completedMilestones": 3,
    },
    {
      "id": 2,
      "name": "Mobile Banking App",
      "description": "Secure mobile banking application with biometric authentication",
      "status": "Planning",
      "priority": "High",
      "progress": 15,
      "startDate": "2024-03-01",
      "endDate": "2024-08-15",
      "budget": 75000.0,
      "spent": 11250.0,
      "teamSize": 12,
      "manager": "Michael Chen",
      "color": Colors.green,
      "completedTasks": 8,
      "totalTasks": 50,
      "issues": 1,
      "milestones": 5,
      "completedMilestones": 1,
    },
    {
      "id": 3,
      "name": "CRM System",
      "description": "Customer relationship management system for enterprise clients",
      "status": "Completed",
      "priority": "Medium",
      "progress": 100,
      "startDate": "2023-09-01",
      "endDate": "2024-02-28",
      "budget": 40000.0,
      "spent": 38000.0,
      "teamSize": 6,
      "manager": "Emily Rodriguez",
      "color": Colors.purple,
      "completedTasks": 35,
      "totalTasks": 35,
      "issues": 0,
      "milestones": 3,
      "completedMilestones": 3,
    },
    {
      "id": 4,
      "name": "Analytics Dashboard",
      "description": "Real-time analytics dashboard for business intelligence",
      "status": "On Hold",
      "priority": "Low",
      "progress": 30,
      "startDate": "2024-02-01",
      "endDate": "2024-07-30",
      "budget": 30000.0,
      "spent": 9000.0,
      "teamSize": 4,
      "manager": "David Thompson",
      "color": Colors.orange,
      "completedTasks": 12,
      "totalTasks": 40,
      "issues": 2,
      "milestones": 3,
      "completedMilestones": 1,
    }
  ];

  List<Map<String, dynamic>> get filteredProjects {
    return projects.where((project) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${project["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${project["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesPriority = selectedPriority.isEmpty ||
          project["priority"] == selectedPriority;
      
      return matchesSearch && matchesPriority;
    }).toList();
  }

  Widget _buildOverviewCards() {
    int totalProjects = projects.length;
    int activeProjects = projects.where((p) => p["status"] == "In Progress").length;
    int completedProjects = projects.where((p) => p["status"] == "Completed").length;
    double totalBudget = projects.fold(0.0, (sum, p) => sum + (p["budget"] as double));
    double totalSpent = projects.fold(0.0, (sum, p) => sum + (p["spent"] as double));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          Icons.dashboard,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Total Projects",
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
                      "$totalProjects",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          Icons.play_circle,
                          color: successColor,
                          size: 24,
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
                      "$activeProjects",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          Icons.check_circle,
                          color: infoColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Completed",
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
                      "$completedProjects",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          Icons.attach_money,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Budget Usage",
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
                      "${((totalSpent / totalBudget) * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: project["color"] as Color,
          ),
        ),
      ),
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
                      "${project["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${project["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
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
                  color: _getStatusColor(project["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${project["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(project["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
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
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (project["progress"] as int) / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: project["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${project["progress"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Budget",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spXs),
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
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${project["manager"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.group,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${project["teamSize"]} members",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Due: ${DateTime.parse(project["endDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('PmaProjectDetailView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  //showProjectOptions
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return successColor;
      case "Completed":
        return infoColor;
      case "Planning":
        return warningColor;
      case "On Hold":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('PmaCreateProjectView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewCards(),
            SizedBox(height: spLg),
            Row(
              children: [
                Expanded(
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
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    //showFilterOptions
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),
            QDropdownField(
              label: "Filter by Priority",
              items: [
                {"label": "All Priorities", "value": ""},
                {"label": "High", "value": "High"},
                {"label": "Medium", "value": "Medium"},
                {"label": "Low", "value": "Low"},
              ],
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            Text(
              "Projects (${filteredProjects.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...filteredProjects.map((project) => _buildProjectCard(project)),
          ],
        ),
      ),
    );
  }
}

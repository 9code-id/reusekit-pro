import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaProjectStatusView extends StatefulWidget {
  const PmaProjectStatusView({super.key});

  @override
  State<PmaProjectStatusView> createState() => _PmaProjectStatusViewState();
}

class _PmaProjectStatusViewState extends State<PmaProjectStatusView> {
  String selectedStatus = "";
  String selectedPriority = "";
  String searchQuery = "";
  
  List<Map<String, dynamic>> projects = [
    {
      "id": 1,
      "name": "E-commerce Platform",
      "status": "In Progress",
      "priority": "High",
      "progress": 75,
      "startDate": "2024-01-15",
      "endDate": "2024-06-30",
      "manager": "Sarah Wilson",
      "teamSize": 8,
      "budget": 50000.0,
      "spent": 37500.0,
      "health": "Good",
      "issues": 3,
      "risksCount": 2,
      "lastUpdate": "2024-06-15",
      "nextMilestone": "Testing Phase",
      "milestoneDue": "2024-06-20",
    },
    {
      "id": 2,
      "name": "Mobile Banking App",
      "status": "Planning",
      "priority": "Critical",
      "progress": 15,
      "startDate": "2024-03-01",
      "endDate": "2024-08-15",
      "manager": "Michael Chen",
      "teamSize": 12,
      "budget": 75000.0,
      "spent": 11250.0,
      "health": "At Risk",
      "issues": 1,
      "risksCount": 4,
      "lastUpdate": "2024-06-14",
      "nextMilestone": "Requirements Approval",
      "milestoneDue": "2024-06-18",
    },
    {
      "id": 3,
      "name": "CRM System",
      "status": "Completed",
      "priority": "Medium",
      "progress": 100,
      "startDate": "2023-09-01",
      "endDate": "2024-02-28",
      "manager": "Emily Rodriguez",
      "teamSize": 6,
      "budget": 40000.0,
      "spent": 38000.0,
      "health": "Excellent",
      "issues": 0,
      "risksCount": 0,
      "lastUpdate": "2024-02-28",
      "nextMilestone": "Project Closure",
      "milestoneDue": "2024-03-05",
    },
    {
      "id": 4,
      "name": "Analytics Dashboard",
      "status": "On Hold",
      "priority": "Low",
      "progress": 30,
      "startDate": "2024-02-01",
      "endDate": "2024-07-30",
      "manager": "David Thompson",
      "teamSize": 4,
      "budget": 30000.0,
      "spent": 9000.0,
      "health": "Poor",
      "issues": 2,
      "risksCount": 3,
      "lastUpdate": "2024-05-20",
      "nextMilestone": "Resource Allocation",
      "milestoneDue": "2024-06-25",
    },
    {
      "id": 5,
      "name": "Inventory Management",
      "status": "In Progress",
      "priority": "High",
      "progress": 60,
      "startDate": "2024-04-01",
      "endDate": "2024-09-30",
      "manager": "Lisa Anderson",
      "teamSize": 5,
      "budget": 35000.0,
      "spent": 21000.0,
      "health": "Good",
      "issues": 1,
      "risksCount": 1,
      "lastUpdate": "2024-06-16",
      "nextMilestone": "Beta Testing",
      "milestoneDue": "2024-07-01",
    },
    {
      "id": 6,
      "name": "HR Portal",
      "status": "Cancelled",
      "priority": "Low",
      "progress": 25,
      "startDate": "2024-01-01",
      "endDate": "2024-06-30",
      "manager": "Robert Kim",
      "teamSize": 3,
      "budget": 25000.0,
      "spent": 6250.0,
      "health": "Poor",
      "issues": 5,
      "risksCount": 6,
      "lastUpdate": "2024-05-15",
      "nextMilestone": "N/A",
      "milestoneDue": "N/A",
    }
  ];

  List<Map<String, dynamic>> get filteredProjects {
    return projects.where((project) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${project["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${project["manager"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty ||
          project["status"] == selectedStatus;
      
      bool matchesPriority = selectedPriority.isEmpty ||
          project["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  Widget _buildStatusSummary() {
    Map<String, int> statusCounts = {};
    for (var project in projects) {
      String status = project["status"];
      statusCounts[status] = (statusCounts[status] ?? 0) + 1;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Status Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildStatusCard("In Progress", statusCounts["In Progress"] ?? 0, successColor),
              SizedBox(width: spSm),
              _buildStatusCard("Planning", statusCounts["Planning"] ?? 0, warningColor),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildStatusCard("Completed", statusCounts["Completed"] ?? 0, infoColor),
              SizedBox(width: spSm),
              _buildStatusCard("On Hold", statusCounts["On Hold"] ?? 0, dangerColor),
            ],
          ),
          if (statusCounts["Cancelled"] != null && statusCounts["Cancelled"]! > 0) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                _buildStatusCard("Cancelled", statusCounts["Cancelled"] ?? 0, disabledBoldColor),
                Expanded(child: Container()),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusCard(String status, int count, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Text(
              "$count",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectStatusCard(Map<String, dynamic> project) {
    Color statusColor = _getStatusColor(project["status"]);
    Color healthColor = _getHealthColor(project["health"]);
    Color priorityColor = _getPriorityColor(project["priority"]);

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
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${project["name"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${project["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
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
                            color: statusColor,
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
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${project["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: healthColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${project["health"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: healthColor,
                      ),
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
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            size: 16,
                            color: warningColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${project["issues"]} Issues",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.error,
                          size: 16,
                          color: dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${project["risksCount"]} Risks",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (project["nextMilestone"] != "N/A") ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.flag,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Next: ${project["nextMilestone"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Due: ${DateTime.parse(project["milestoneDue"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
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
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('PmaEditProjectView')
                },
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
      case "Cancelled":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getHealthColor(String health) {
    switch (health) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "At Risk":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildStatusSummary(),
            SizedBox(height: spLg),
            QTextField(
              label: "Search projects...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
                    items: [
                      {"label": "All Status", "value": ""},
                      {"label": "In Progress", "value": "In Progress"},
                      {"label": "Planning", "value": "Planning"},
                      {"label": "Completed", "value": "Completed"},
                      {"label": "On Hold", "value": "On Hold"},
                      {"label": "Cancelled", "value": "Cancelled"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Priority",
                    items: [
                      {"label": "All Priority", "value": ""},
                      {"label": "Critical", "value": "Critical"},
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
                ),
              ],
            ),
            SizedBox(height: spLg),
            Row(
              children: [
                Text(
                  "Projects (${filteredProjects.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {
                    //showSortOptions
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),
            ...filteredProjects.map((project) => _buildProjectStatusCard(project)),
          ],
        ),
      ),
    );
  }
}

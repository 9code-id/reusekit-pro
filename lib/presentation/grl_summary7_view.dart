import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSummary7View extends StatefulWidget {
  @override
  State<GrlSummary7View> createState() => _GrlSummary7ViewState();
}

class _GrlSummary7ViewState extends State<GrlSummary7View> {
  List<Map<String, dynamic>> projectData = [
    {
      "name": "E-commerce Platform",
      "status": "in_progress",
      "progress": 75.0,
      "budget": 180000.0,
      "spent": 135000.0,
      "deadline": "2024-12-15",
      "team_size": 8,
      "priority": "high",
      "client": "TechCorp Inc.",
      "manager": "John Smith",
    },
    {
      "name": "Mobile Banking App",
      "status": "completed",
      "progress": 100.0,
      "budget": 220000.0,
      "spent": 215000.0,
      "deadline": "2024-11-30",
      "team_size": 12,
      "priority": "high",
      "client": "First Bank",
      "manager": "Sarah Chen",
    },
    {
      "name": "CRM Integration",
      "status": "in_progress",
      "progress": 45.0,
      "budget": 95000.0,
      "spent": 38000.0,
      "deadline": "2025-01-20",
      "team_size": 5,
      "priority": "medium",
      "client": "Sales Pro Ltd",
      "manager": "Mike Johnson",
    },
    {
      "name": "AI Analytics Dashboard",
      "status": "planning",
      "progress": 15.0,
      "budget": 150000.0,
      "spent": 22000.0,
      "deadline": "2025-03-10",
      "team_size": 6,
      "priority": "medium",
      "client": "Data Solutions",
      "manager": "Emily Davis",
    },
    {
      "name": "Security Audit System",
      "status": "on_hold",
      "progress": 25.0,
      "budget": 75000.0,
      "spent": 18000.0,
      "deadline": "2025-02-28",
      "team_size": 4,
      "priority": "low",
      "client": "SecureIT Corp",
      "manager": "David Wilson",
    },
  ];

  List<Map<String, dynamic>> resourceAllocation = [
    {
      "department": "Frontend Development",
      "allocated": 24,
      "available": 6,
      "utilization": 75.0,
    },
    {
      "department": "Backend Development", 
      "allocated": 18,
      "available": 3,
      "utilization": 83.3,
    },
    {
      "department": "UI/UX Design",
      "allocated": 12,
      "available": 4,
      "utilization": 66.7,
    },
    {
      "department": "Quality Assurance",
      "allocated": 8,
      "available": 2,
      "utilization": 75.0,
    },
    {
      "department": "Project Management",
      "allocated": 6,
      "available": 1,
      "utilization": 83.3,
    },
  ];

  List<Map<String, dynamic>> milestones = [
    {
      "project": "E-commerce Platform",
      "milestone": "Payment Gateway Integration",
      "due_date": "2024-12-20",
      "status": "upcoming",
      "days_left": 5,
    },
    {
      "project": "Mobile Banking App",
      "milestone": "Security Testing Complete",
      "due_date": "2024-12-15",
      "status": "completed",
      "days_left": 0,
    },
    {
      "project": "CRM Integration",
      "milestone": "API Development Phase",
      "due_date": "2024-12-25",
      "status": "in_progress",
      "days_left": 10,
    },
    {
      "project": "AI Analytics Dashboard",
      "milestone": "Requirement Analysis",
      "due_date": "2024-12-30",
      "status": "pending",
      "days_left": 15,
    },
  ];

  String selectedFilter = "all";

  @override
  Widget build(BuildContext context) {
    final totalBudget = projectData.fold(0.0, (sum, project) => sum + (project["budget"] as double));
    final totalSpent = projectData.fold(0.0, (sum, project) => sum + (project["spent"] as double));
    final activeProjects = projectData.where((p) => p["status"] == "in_progress").length;
    final completedProjects = projectData.where((p) => p["status"] == "completed").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Project Summary Dashboard"),
        actions: [
          Icon(Icons.dashboard, color: primaryColor),
          SizedBox(width: spSm),
          Icon(Icons.filter_alt, color: primaryColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(153)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.work, color: Colors.white, size: 28),
                      SizedBox(width: spSm),
                      Text(
                        "Project Portfolio Overview",
                        style: TextStyle(
                          fontSize: fsH5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
                              "Total Projects",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${projectData.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                              "Active",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "$activeProjects",
                              style: TextStyle(
                                fontSize: fsH3,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                              "Budget Used",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${((totalSpent / totalBudget) * 100).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: fsH3,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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

            QCategoryPicker(
              items: [
                {"label": "All Projects", "value": "all"},
                {"label": "Active", "value": "in_progress"},
                {"label": "Completed", "value": "completed"},
                {"label": "High Priority", "value": "high"},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Project Status Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: projectData.map((project) {
                      Color statusColor = primaryColor;
                      IconData statusIcon = Icons.work;
                      String statusText = project["status"];
                      
                      switch (project["status"]) {
                        case "completed":
                          statusColor = successColor;
                          statusIcon = Icons.check_circle;
                          statusText = "Completed";
                          break;
                        case "in_progress":
                          statusColor = warningColor;
                          statusIcon = Icons.play_circle;
                          statusText = "In Progress";
                          break;
                        case "planning":
                          statusColor = infoColor;
                          statusIcon = Icons.schedule;
                          statusText = "Planning";
                          break;
                        case "on_hold":
                          statusColor = dangerColor;
                          statusIcon = Icons.pause_circle;
                          statusText = "On Hold";
                          break;
                      }
                      
                      final budgetUsed = ((project["spent"] as double) / (project["budget"] as double)) * 100;
                      final isOverBudget = budgetUsed > 90;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(26),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    statusIcon,
                                    color: statusColor,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spSm),
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
                                        "Client: ${project["client"]} • Manager: ${project["manager"]}",
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
                                    color: statusColor.withAlpha(26),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    statusText,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
                                        "Progress: ${(project["progress"] as double).toStringAsFixed(0)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Container(
                                        height: 4,
                                        margin: EdgeInsets.only(top: spXs),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: (project["progress"] as double) / 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: statusColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                          ),
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
                                      "\$${(project["spent"] as double).currency} / \$${(project["budget"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isOverBudget ? dangerColor : primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${budgetUsed.toStringAsFixed(0)}% budget used",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.people, color: disabledBoldColor, size: 14),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${project["team_size"]} team members",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, color: disabledBoldColor, size: 14),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Due: ${DateTime.parse(project["deadline"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
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

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Resource Allocation",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: resourceAllocation.map((resource) {
                      final utilization = resource["utilization"] as double;
                      Color utilizationColor = successColor;
                      if (utilization > 80) utilizationColor = warningColor;
                      if (utilization > 90) utilizationColor = dangerColor;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${resource["department"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${resource["allocated"]} allocated • ${resource["available"]} available",
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
                                  "${utilization.toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: utilizationColor,
                                  ),
                                ),
                                Text(
                                  "Utilization",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
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

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Upcoming Milestones",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Icon(Icons.flag, color: primaryColor, size: 20),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: milestones.map((milestone) {
                      Color statusColor = primaryColor;
                      IconData statusIcon = Icons.schedule;
                      
                      switch (milestone["status"]) {
                        case "completed":
                          statusColor = successColor;
                          statusIcon = Icons.check_circle;
                          break;
                        case "in_progress":
                          statusColor = warningColor;
                          statusIcon = Icons.play_circle;
                          break;
                        case "upcoming":
                          statusColor = infoColor;
                          statusIcon = Icons.upcoming;
                          break;
                        case "pending":
                          statusColor = dangerColor;
                          statusIcon = Icons.pending;
                          break;
                      }
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                statusIcon,
                                color: statusColor,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${milestone["milestone"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${milestone["project"]}",
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
                                  "${DateTime.parse(milestone["due_date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                if ((milestone["days_left"] as int) > 0)
                                  Text(
                                    "${milestone["days_left"]} days left",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: statusColor,
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

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Create Project",
                    icon: Icons.add,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

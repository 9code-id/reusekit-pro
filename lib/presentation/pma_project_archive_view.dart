import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaProjectArchiveView extends StatefulWidget {
  const PmaProjectArchiveView({super.key});

  @override
  State<PmaProjectArchiveView> createState() => _PmaProjectArchiveViewState();
}

class _PmaProjectArchiveViewState extends State<PmaProjectArchiveView> {
  String searchQuery = "";
  String selectedYear = "";
  String selectedStatus = "";
  String sortBy = "Date Archived";
  
  List<Map<String, dynamic>> archivedProjects = [
    {
      "id": 1,
      "name": "Legacy CRM System",
      "description": "Old customer relationship management system",
      "originalStatus": "Completed",
      "archivedDate": "2024-05-15",
      "completionDate": "2024-05-10",
      "startDate": "2023-08-01",
      "endDate": "2024-05-10",
      "manager": "Robert Johnson",
      "teamSize": 6,
      "budget": 45000.0,
      "spent": 43500.0,
      "finalProgress": 100,
      "archiveReason": "Project completed successfully",
      "category": "Internal Tools",
      "priority": "Medium",
      "filesCount": 245,
      "tasksCount": 58,
      "documentsCount": 23,
    },
    {
      "id": 2,
      "name": "Mobile App Version 1.0",
      "description": "First version of company mobile application",
      "originalStatus": "Completed",
      "archivedDate": "2024-04-20",
      "completionDate": "2024-04-15",
      "startDate": "2023-10-01",
      "endDate": "2024-04-15",
      "manager": "Lisa Chen",
      "teamSize": 8,
      "budget": 60000.0,
      "spent": 58200.0,
      "finalProgress": 100,
      "archiveReason": "Replaced by version 2.0",
      "category": "Mobile Development",
      "priority": "High",
      "filesCount": 387,
      "tasksCount": 94,
      "documentsCount": 45,
    },
    {
      "id": 3,
      "name": "Data Migration Tool",
      "description": "Tool for migrating data from legacy systems",
      "originalStatus": "Cancelled",
      "archivedDate": "2024-03-10",
      "completionDate": null,
      "startDate": "2023-12-01",
      "endDate": "2024-06-01",
      "manager": "David Park",
      "teamSize": 4,
      "budget": 25000.0,
      "spent": 12500.0,
      "finalProgress": 45,
      "archiveReason": "Project requirements changed",
      "category": "Data Management",
      "priority": "Low",
      "filesCount": 156,
      "tasksCount": 32,
      "documentsCount": 12,
    },
    {
      "id": 4,
      "name": "Website Redesign 2023",
      "description": "Complete redesign of company website",
      "originalStatus": "Completed",
      "archivedDate": "2024-02-28",
      "completionDate": "2024-02-20",
      "startDate": "2023-09-01",
      "endDate": "2024-02-20",
      "manager": "Sarah Martinez",
      "teamSize": 5,
      "budget": 35000.0,
      "spent": 33800.0,
      "finalProgress": 100,
      "archiveReason": "Successfully launched",
      "category": "Web Development",
      "priority": "High",
      "filesCount": 298,
      "tasksCount": 67,
      "documentsCount": 34,
    },
    {
      "id": 5,
      "name": "Internal Chat System",
      "description": "Real-time chat system for internal communication",
      "originalStatus": "On Hold",
      "archivedDate": "2024-01-15",
      "completionDate": null,
      "startDate": "2023-07-01",
      "endDate": "2024-03-01",
      "manager": "Alex Thompson",
      "teamSize": 3,
      "budget": 20000.0,
      "spent": 8000.0,
      "finalProgress": 30,
      "archiveReason": "Budget constraints",
      "category": "Communication Tools",
      "priority": "Medium",
      "filesCount": 89,
      "tasksCount": 21,
      "documentsCount": 8,
    },
    {
      "id": 6,
      "name": "Inventory Tracking Beta",
      "description": "Beta version of inventory tracking system",
      "originalStatus": "Completed",
      "archivedDate": "2023-12-31",
      "completionDate": "2023-12-20",
      "startDate": "2023-06-01",
      "endDate": "2023-12-20",
      "manager": "Maria Rodriguez",
      "teamSize": 7,
      "budget": 40000.0,
      "spent": 39200.0,
      "finalProgress": 100,
      "archiveReason": "Superseded by new version",
      "category": "Enterprise Software",
      "priority": "Medium",
      "filesCount": 334,
      "tasksCount": 76,
      "documentsCount": 28,
    }
  ];

  List<Map<String, dynamic>> get filteredProjects {
    List<Map<String, dynamic>> filtered = archivedProjects.where((project) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${project["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${project["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${project["manager"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesYear = selectedYear.isEmpty ||
          DateTime.parse(project["archivedDate"]).year.toString() == selectedYear;
      
      bool matchesStatus = selectedStatus.isEmpty ||
          project["originalStatus"] == selectedStatus;
      
      return matchesSearch && matchesYear && matchesStatus;
    }).toList();

    // Sort the filtered list
    if (sortBy == "Date Archived") {
      filtered.sort((a, b) => DateTime.parse(b["archivedDate"]).compareTo(DateTime.parse(a["archivedDate"])));
    } else if (sortBy == "Project Name") {
      filtered.sort((a, b) => a["name"].compareTo(b["name"]));
    } else if (sortBy == "Budget") {
      filtered.sort((a, b) => (b["budget"] as double).compareTo(a["budget"] as double));
    }

    return filtered;
  }

  Widget _buildArchiveStats() {
    int totalProjects = archivedProjects.length;
    int completedProjects = archivedProjects.where((p) => p["originalStatus"] == "Completed").length;
    int cancelledProjects = archivedProjects.where((p) => p["originalStatus"] == "Cancelled").length;
    double totalBudget = archivedProjects.fold(0.0, (sum, p) => sum + (p["budget"] as double));
    double totalSpent = archivedProjects.fold(0.0, (sum, p) => sum + (p["spent"] as double));

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
            "Archive Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildStatCard("Total Archived", "$totalProjects", Icons.archive, primaryColor),
              SizedBox(width: spSm),
              _buildStatCard("Completed", "$completedProjects", Icons.check_circle, successColor),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildStatCard("Cancelled", "$cancelledProjects", Icons.cancel, dangerColor),
              SizedBox(width: spSm),
              _buildStatCard("Budget Used", "${((totalSpent / totalBudget) * 100).toStringAsFixed(1)}%", Icons.attach_money, warningColor),
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
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
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

  Widget _buildArchivedProjectCard(Map<String, dynamic> project) {
    Color statusColor = _getStatusColor(project["originalStatus"]);

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
            color: disabledBoldColor,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                      "${project["originalStatus"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Archived: ${DateTime.parse(project["archivedDate"]).dMMMy}",
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
                      child: _buildProjectStat("Progress", "${project["finalProgress"]}%"),
                    ),
                    Expanded(
                      child: _buildProjectStat("Budget", "\$${((project["budget"] as double)).currency}"),
                    ),
                    Expanded(
                      child: _buildProjectStat("Spent", "\$${((project["spent"] as double)).currency}"),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildProjectStat("Files", "${project["filesCount"]}"),
                    ),
                    Expanded(
                      child: _buildProjectStat("Tasks", "${project["tasksCount"]}"),
                    ),
                    Expanded(
                      child: _buildProjectStat("Docs", "${project["documentsCount"]}"),
                    ),
                  ],
                ),
              ],
            ),
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
              SizedBox(width: spMd),
              Icon(
                Icons.category,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${project["category"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  size: 16,
                  color: warningColor,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Archive Reason: ${project["archiveReason"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
                    //navigateTo('PmaArchivedProjectDetailView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.unarchive,
                size: bs.sm,
                onPressed: () async {
                  bool isConfirmed = await confirm("Restore this project from archive?");
                  if (isConfirmed) {
                    ss("Project restored successfully!");
                  }
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {
                  ss("Downloading project files...");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.delete_forever,
                size: bs.sm,
                onPressed: () async {
                  bool isConfirmed = await confirm("Permanently delete this project? This action cannot be undone.");
                  if (isConfirmed) {
                    se("Permanent deletion not implemented");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Cancelled":
        return dangerColor;
      case "On Hold":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Archive"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              si("Archive contains completed, cancelled, and old projects for reference and compliance.");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildArchiveStats(),
            SizedBox(height: spLg),
            QTextField(
              label: "Search archived projects...",
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
                    label: "Year",
                    items: [
                      {"label": "All Years", "value": ""},
                      {"label": "2024", "value": "2024"},
                      {"label": "2023", "value": "2023"},
                      {"label": "2022", "value": "2022"},
                    ],
                    value: selectedYear,
                    onChanged: (value, label) {
                      selectedYear = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": ""},
                      {"label": "Completed", "value": "Completed"},
                      {"label": "Cancelled", "value": "Cancelled"},
                      {"label": "On Hold", "value": "On Hold"},
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
            SizedBox(height: spMd),
            QDropdownField(
              label: "Sort By",
              items: [
                {"label": "Date Archived", "value": "Date Archived"},
                {"label": "Project Name", "value": "Project Name"},
                {"label": "Budget", "value": "Budget"},
              ],
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            Row(
              children: [
                Text(
                  "Archived Projects (${filteredProjects.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.cloud_download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Exporting archive data...");
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),
            ...filteredProjects.map((project) => _buildArchivedProjectCard(project)),
          ],
        ),
      ),
    );
  }
}

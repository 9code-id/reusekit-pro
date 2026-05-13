import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmWorkspaceListView extends StatefulWidget {
  const TpmWorkspaceListView({super.key});

  @override
  State<TpmWorkspaceListView> createState() => _TpmWorkspaceListViewState();
}

class _TpmWorkspaceListViewState extends State<TpmWorkspaceListView> {
  String searchQuery = "";
  String selectedFilter = "All";
  bool isGridView = false;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "My Workspaces", "value": "My Workspaces"},
    {"label": "Shared", "value": "Shared"},
    {"label": "Recent", "value": "Recent"},
    {"label": "Favorites", "value": "Favorites"},
  ];

  List<Map<String, dynamic>> workspaces = [
    {
      "id": "1",
      "name": "Mobile App Development",
      "description": "iOS and Android application development project",
      "status": "Active",
      "progress": 75,
      "members": 8,
      "tasks": 24,
      "completedTasks": 18,
      "dueDate": "2024-06-30",
      "owner": "John Smith",
      "isOwner": true,
      "isFavorite": true,
      "lastActivity": "2 hours ago",
      "color": primaryColor,
      "category": "Development",
    },
    {
      "id": "2", 
      "name": "Marketing Campaign Q2",
      "description": "Second quarter marketing initiatives and campaigns",
      "status": "Active",
      "progress": 60,
      "members": 5,
      "tasks": 16,
      "completedTasks": 10,
      "dueDate": "2024-05-31",
      "owner": "Sarah Wilson",
      "isOwner": false,
      "isFavorite": false,
      "lastActivity": "1 day ago",
      "color": successColor,
      "category": "Marketing",
    },
    {
      "id": "3",
      "name": "Website Redesign",
      "description": "Complete redesign of company website with new UI/UX",
      "status": "Planning",
      "progress": 25,
      "members": 6,
      "tasks": 12,
      "completedTasks": 3,
      "dueDate": "2024-07-15",
      "owner": "Mike Chen",
      "isOwner": false,
      "isFavorite": true,
      "lastActivity": "3 hours ago",
      "color": infoColor,
      "category": "Design",
    },
    {
      "id": "4",
      "name": "Data Analytics Platform",
      "description": "Building internal analytics platform for business intelligence",
      "status": "Active",
      "progress": 90,
      "members": 4,
      "tasks": 20,
      "completedTasks": 18,
      "dueDate": "2024-04-30",
      "owner": "Alex Johnson",
      "isOwner": true,
      "isFavorite": false,
      "lastActivity": "5 hours ago",
      "color": warningColor,
      "category": "Development",
    },
    {
      "id": "5",
      "name": "HR Process Automation",
      "description": "Automating HR processes and implementing new HRIS",
      "status": "Completed",
      "progress": 100,
      "members": 3,
      "tasks": 15,
      "completedTasks": 15,
      "dueDate": "2024-03-31",
      "owner": "Emma Davis",
      "isOwner": false,
      "isFavorite": false,
      "lastActivity": "1 week ago",
      "color": disabledBoldColor,
      "category": "HR",
    },
    {
      "id": "6",
      "name": "Product Launch Preparation",
      "description": "Preparing for the launch of our new product line",
      "status": "Planning",
      "progress": 15,
      "members": 10,
      "tasks": 30,
      "completedTasks": 5,
      "dueDate": "2024-08-01",
      "owner": "David Wilson",
      "isOwner": false,
      "isFavorite": true,
      "lastActivity": "4 hours ago",
      "color": primaryColor,
      "category": "Product",
    },
  ];

  List<Map<String, dynamic>> get filteredWorkspaces {
    return workspaces.where((workspace) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${workspace["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${workspace["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" ||
          (selectedFilter == "My Workspaces" && workspace["isOwner"] == true) ||
          (selectedFilter == "Shared" && workspace["isOwner"] == false) ||
          (selectedFilter == "Favorites" && workspace["isFavorite"] == true) ||
          (selectedFilter == "Recent" && ["2 hours ago", "1 day ago", "3 hours ago", "4 hours ago"].contains(workspace["lastActivity"]));
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active": return successColor;
      case "Planning": return warningColor;
      case "Completed": return infoColor;
      case "On Hold": return dangerColor;
      default: return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workspaces"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create workspace
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search workspaces...",
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
                  onPressed: () {},
                ),
              ],
            ),

            // Filter Tabs
            QCategoryPicker(
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Summary Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${workspaces.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Workspaces",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${workspaces.where((w) => w["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${workspaces.where((w) => w["isOwner"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Owned",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Workspaces Grid/List
            if (isGridView) ...[
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredWorkspaces.map((workspace) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: (workspace["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.work,
                                color: workspace["color"] as Color,
                                size: 20,
                              ),
                            ),
                            Spacer(),
                            if (workspace["isFavorite"] == true) ...[
                              Icon(Icons.favorite, color: dangerColor, size: 16),
                            ],
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${workspace["status"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${workspace["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getStatusColor("${workspace["status"]}"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${workspace["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${workspace["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Progress: ${workspace["progress"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${workspace["completedTasks"]}/${workspace["tasks"]} tasks",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            LinearProgressIndicator(
                              value: (workspace["progress"] as int) / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(workspace["color"] as Color),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.group, size: 12, color: disabledBoldColor),
                            SizedBox(width: 4),
                            Text(
                              "${workspace["members"]} members",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                            SizedBox(width: 4),
                            Text(
                              "${workspace["lastActivity"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Open",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to workspace detail
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ] else ...[
              Column(
                spacing: spSm,
                children: filteredWorkspaces.map((workspace) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (workspace["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.work,
                                color: workspace["color"] as Color,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${workspace["name"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      if (workspace["isFavorite"] == true) ...[
                                        Icon(Icons.favorite, color: dangerColor, size: 16),
                                        SizedBox(width: spXs),
                                      ],
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${workspace["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${workspace["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: _getStatusColor("${workspace["status"]}"),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${workspace["description"]}",
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
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Progress: ${workspace["progress"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${workspace["completedTasks"]}/${workspace["tasks"]} tasks completed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            LinearProgressIndicator(
                              value: (workspace["progress"] as int) / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(workspace["color"] as Color),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.group, size: 14, color: disabledBoldColor),
                            SizedBox(width: 4),
                            Text(
                              "${workspace["members"]} members",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.person, size: 14, color: disabledBoldColor),
                            SizedBox(width: 4),
                            Text(
                              "Owner: ${workspace["owner"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${workspace["lastActivity"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            QButton(
                              label: "Open Workspace",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to workspace detail
                              },
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            Spacer(),
                            Text(
                              "Due: ${workspace["dueDate"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
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

            // Create New Workspace Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Column(
                children: [
                  Icon(Icons.add_circle, color: primaryColor, size: 48),
                  SizedBox(height: spSm),
                  Text(
                    "Create New Workspace",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Start a new project and collaborate with your team",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Get Started",
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to create workspace
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

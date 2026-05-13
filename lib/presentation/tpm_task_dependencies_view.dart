import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTaskDependenciesView extends StatefulWidget {
  const TpmTaskDependenciesView({super.key});

  @override
  State<TpmTaskDependenciesView> createState() => _TpmTaskDependenciesViewState();
}

class _TpmTaskDependenciesViewState extends State<TpmTaskDependenciesView> {
  String searchQuery = "";
  String selectedType = "";
  int currentTab = 0;

  List<Map<String, dynamic>> dependencies = [
    {
      "id": 1,
      "sourceTask": "Database Design",
      "targetTask": "API Development",
      "type": "Finish-to-Start",
      "lag": 0,
      "status": "Active",
      "sourceTaskId": "TSK-001",
      "targetTaskId": "TSK-002",
      "sourceProgress": 100,
      "targetProgress": 45,
      "createdDate": "2024-12-01",
      "createdBy": "Sarah Johnson",
      "description": "API development cannot start until database design is complete"
    },
    {
      "id": 2,
      "sourceTask": "UI Mockups",
      "targetTask": "Frontend Development",
      "type": "Start-to-Start",
      "lag": 2,
      "status": "Active",
      "sourceTaskId": "DSN-001",
      "targetTaskId": "FE-001",
      "sourceProgress": 80,
      "targetProgress": 30,
      "createdDate": "2024-12-03",
      "createdBy": "Michael Chen",
      "description": "Frontend development can start 2 days after UI mockups begin"
    },
    {
      "id": 3,
      "sourceTask": "API Development",
      "targetTask": "Integration Testing",
      "type": "Finish-to-Finish",
      "lag": -1,
      "status": "Pending",
      "sourceTaskId": "TSK-002",
      "targetTaskId": "TST-001",
      "sourceProgress": 45,
      "targetProgress": 0,
      "createdDate": "2024-12-05",
      "createdBy": "David Rodriguez",
      "description": "Integration testing must finish 1 day before API development completion"
    },
    {
      "id": 4,
      "sourceTask": "Content Creation",
      "targetTask": "Content Review",
      "type": "Start-to-Finish",
      "lag": 3,
      "status": "Violated",
      "sourceTaskId": "CNT-001",
      "targetTaskId": "CNT-002",
      "sourceProgress": 90,
      "targetProgress": 100,
      "createdDate": "2024-11-28",
      "createdBy": "Emma Wilson",
      "description": "Content review must finish 3 days after content creation starts"
    }
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "id": "TSK-001",
      "title": "Database Design",
      "status": "Completed",
      "progress": 100,
      "assignee": "Michael Chen",
      "dueDate": "2024-12-15"
    },
    {
      "id": "TSK-002",
      "title": "API Development",
      "status": "In Progress",
      "progress": 45,
      "assignee": "John Smith",
      "dueDate": "2024-12-25"
    },
    {
      "id": "DSN-001",
      "title": "UI Mockups",
      "status": "In Progress",
      "progress": 80,
      "assignee": "Emma Wilson",
      "dueDate": "2024-12-20"
    },
    {
      "id": "FE-001",
      "title": "Frontend Development",
      "status": "In Progress",
      "progress": 30,
      "assignee": "Lisa Park",
      "dueDate": "2024-12-30"
    }
  ];

  List<Map<String, dynamic>> dependencyTypes = [
    {"label": "All Types", "value": ""},
    {"label": "Finish-to-Start", "value": "Finish-to-Start"},
    {"label": "Start-to-Start", "value": "Start-to-Start"},
    {"label": "Finish-to-Finish", "value": "Finish-to-Finish"},
    {"label": "Start-to-Finish", "value": "Start-to-Finish"}
  ];

  List<Map<String, dynamic>> get filteredDependencies {
    return dependencies.where((dependency) {
      bool matchesSearch = searchQuery.isEmpty ||
          (dependency["sourceTask"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (dependency["targetTask"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType.isEmpty ||
          dependency["type"] == selectedType;
      
      return matchesSearch && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Violated":
        return dangerColor;
      case "Completed":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Finish-to-Start":
        return primaryColor;
      case "Start-to-Start":
        return successColor;
      case "Finish-to-Finish":
        return warningColor;
      case "Start-to-Finish":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Task Dependencies",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dependencies", icon: Icon(Icons.account_tree)),
        Tab(text: "Visual Map", icon: Icon(Icons.hub)),
      ],
      tabChildren: [
        _buildDependenciesTab(),
        _buildVisualMapTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildDependenciesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search dependencies...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () => _showAddDependencyDialog(),
              ),
            ],
          ),

          QDropdownField(
            label: "Dependency Type",
            items: dependencyTypes,
            value: selectedType,
            onChanged: (value, label) {
              selectedType = value;
              setState(() {});
            },
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryColor.withAlpha(200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.account_tree, color: Colors.white, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Total Dependencies",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "${dependencies.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                    gradient: LinearGradient(
                      colors: [dangerColor, dangerColor.withAlpha(200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.warning, color: Colors.white, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Violated",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "${dependencies.where((d) => d["status"] == "Violated").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Dependency Types",
                      style: TextStyle(
                        color: infoColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Finish-to-Start: Task B starts after Task A finishes\n• Start-to-Start: Task B starts when Task A starts\n• Finish-to-Finish: Task B finishes when Task A finishes\n• Start-to-Finish: Task B finishes when Task A starts",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredDependencies.length,
            itemBuilder: (context, index) {
              final dependency = filteredDependencies[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: _getStatusColor("${dependency["status"]}").withAlpha(100),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${dependency["sourceTask"]} → ${dependency["targetTask"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${dependency["sourceTaskId"]} → ${dependency["targetTaskId"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${dependency["status"]}").withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${dependency["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor("${dependency["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getTypeColor("${dependency["type"]}").withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${dependency["type"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getTypeColor("${dependency["type"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if ((dependency["lag"] as int) != 0) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Lag: ${dependency["lag"]} days",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),

                    if ((dependency["description"] as String).isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${dependency["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Source Progress: ${dependency["sourceProgress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: (dependency["sourceProgress"] as int) / 100,
                                backgroundColor: disabledColor.withAlpha(30),
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Target Progress: ${dependency["targetProgress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: (dependency["targetProgress"] as int) / 100,
                                backgroundColor: disabledColor.withAlpha(30),
                                valueColor: AlwaysStoppedAnimation<Color>(successColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          "Created by ${dependency["createdBy"]} on ${dependency["createdDate"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () => _editDependency(dependency),
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.delete,
                          size: bs.sm,
                          onPressed: () => _deleteDependency(dependency),
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
    );
  }

  Widget _buildVisualMapTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: warningColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Visual dependency map shows task relationships and flow",
                    style: TextStyle(
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            height: 400,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTaskNode("Database Design", "TSK-001", 100, successColor),
                    _buildTaskNode("UI Mockups", "DSN-001", 80, warningColor),
                  ],
                ),
                SizedBox(height: spLg),
                Container(
                  height: 2,
                  color: primaryColor,
                  margin: EdgeInsets.symmetric(horizontal: spLg),
                ),
                SizedBox(height: spLg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTaskNode("API Development", "TSK-002", 45, warningColor),
                    _buildTaskNode("Frontend Dev", "FE-001", 30, dangerColor),
                  ],
                ),
                SizedBox(height: spLg),
                Container(
                  height: 2,
                  color: primaryColor,
                  margin: EdgeInsets.symmetric(horizontal: spLg),
                ),
                SizedBox(height: spLg),
                _buildTaskNode("Integration Testing", "TST-001", 0, disabledColor),
              ],
            ),
          ),

          Container(
            width: double.infinity,
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
                Text(
                  "Legend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: successColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text("Completed (100%)", style: TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: warningColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text("In Progress (50-99%)", style: TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: dangerColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text("At Risk (1-49%)", style: TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text("Not Started (0%)", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "View Full Network Diagram",
              onPressed: () => _showFullNetworkDiagram(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskNode(String title, String id, int progress, Color color) {
    return Container(
      width: 120,
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            id,
            style: TextStyle(
              fontSize: 10,
              color: color.withAlpha(150),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "$progress%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDependencyDialog() {
    // Implementation for adding new dependency
  }

  void _editDependency(Map<String, dynamic> dependency) {
    // Implementation for editing dependency
  }

  void _deleteDependency(Map<String, dynamic> dependency) {
    // Implementation for deleting dependency
  }

  void _showFullNetworkDiagram() {
    // Implementation for showing full network diagram
  }
}

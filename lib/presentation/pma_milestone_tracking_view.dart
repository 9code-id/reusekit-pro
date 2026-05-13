import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaMilestoneTrackingView extends StatefulWidget {
  const PmaMilestoneTrackingView({super.key});

  @override
  State<PmaMilestoneTrackingView> createState() => _PmaMilestoneTrackingViewState();
}

class _PmaMilestoneTrackingViewState extends State<PmaMilestoneTrackingView> {
  String selectedProject = "All Projects";
  String selectedTimeframe = "This Quarter";
  String selectedStatus = "All Status";
  
  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "E-commerce Platform", "value": "ecommerce"},
    {"label": "Mobile App Redesign", "value": "mobile"},
    {"label": "Data Analytics Tool", "value": "analytics"},
    {"label": "CRM Integration", "value": "crm"},
  ];
  
  List<Map<String, dynamic>> timeframes = [
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 6 Months", "value": "6months"},
    {"label": "This Year", "value": "year"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "On Track", "value": "on_track"},
    {"label": "At Risk", "value": "at_risk"},
    {"label": "Delayed", "value": "delayed"},
    {"label": "Completed", "value": "completed"},
  ];
  
  List<Map<String, dynamic>> milestones = [
    {
      "id": "MS001",
      "title": "User Authentication System",
      "project": "E-commerce Platform",
      "start_date": "2024-01-15",
      "due_date": "2024-02-15",
      "completion_date": "2024-02-10",
      "status": "completed",
      "progress": 100,
      "planned_hours": 120,
      "actual_hours": 115,
      "tasks_total": 8,
      "tasks_completed": 8,
      "priority": "high",
      "owner": "John Smith",
      "budget": 15000,
      "spent": 14500,
    },
    {
      "id": "MS002",
      "title": "Payment Gateway Integration",
      "project": "E-commerce Platform",
      "start_date": "2024-02-01",
      "due_date": "2024-03-01",
      "completion_date": null,
      "status": "on_track",
      "progress": 75,
      "planned_hours": 80,
      "actual_hours": 58,
      "tasks_total": 6,
      "tasks_completed": 4,
      "priority": "high",
      "owner": "Sarah Johnson",
      "budget": 12000,
      "spent": 8500,
    },
    {
      "id": "MS003",
      "title": "Product Catalog Redesign",
      "project": "E-commerce Platform",
      "start_date": "2024-01-20",
      "due_date": "2024-02-20",
      "completion_date": null,
      "status": "at_risk",
      "progress": 45,
      "planned_hours": 100,
      "actual_hours": 85,
      "tasks_total": 10,
      "tasks_completed": 4,
      "priority": "medium",
      "owner": "Mike Wilson",
      "budget": 18000,
      "spent": 15000,
    },
    {
      "id": "MS004",
      "title": "Mobile Responsive Design",
      "project": "Mobile App Redesign",
      "start_date": "2024-02-10",
      "due_date": "2024-03-15",
      "completion_date": null,
      "status": "delayed",
      "progress": 30,
      "planned_hours": 150,
      "actual_hours": 120,
      "tasks_total": 12,
      "tasks_completed": 3,
      "priority": "high",
      "owner": "Emily Davis",
      "budget": 22000,
      "spent": 18000,
    },
    {
      "id": "MS005",
      "title": "User Interface Components",
      "project": "Mobile App Redesign",
      "start_date": "2024-01-25",
      "due_date": "2024-02-25",
      "completion_date": null,
      "status": "on_track",
      "progress": 80,
      "planned_hours": 90,
      "actual_hours": 70,
      "tasks_total": 8,
      "tasks_completed": 6,
      "priority": "medium",
      "owner": "David Brown",
      "budget": 16000,
      "spent": 12000,
    },
    {
      "id": "MS006",
      "title": "Data Visualization Dashboard",
      "project": "Data Analytics Tool",
      "start_date": "2024-02-05",
      "due_date": "2024-03-10",
      "completion_date": null,
      "status": "on_track",
      "progress": 60,
      "planned_hours": 110,
      "actual_hours": 65,
      "tasks_total": 9,
      "tasks_completed": 5,
      "priority": "high",
      "owner": "Lisa Anderson",
      "budget": 20000,
      "spent": 12500,
    },
  ];
  
  List<Map<String, dynamic>> get filteredMilestones {
    return milestones.where((milestone) {
      bool projectMatch = selectedProject == "All Projects" || 
                         milestone["project"] == selectedProject;
      bool statusMatch = selectedStatus == "All Status" || 
                        milestone["status"] == selectedStatus;
      return projectMatch && statusMatch;
    }).toList();
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "on_track":
        return primaryColor;
      case "at_risk":
        return warningColor;
      case "delayed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }
  
  String _getStatusLabel(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "on_track":
        return "On Track";
      case "at_risk":
        return "At Risk";
      case "delayed":
        return "Delayed";
      default:
        return "Unknown";
    }
  }
  
  Widget _buildSummaryCards() {
    int totalMilestones = filteredMilestones.length;
    int completedMilestones = filteredMilestones.where((m) => m["status"] == "completed").length;
    int onTrackMilestones = filteredMilestones.where((m) => m["status"] == "on_track").length;
    int atRiskMilestones = filteredMilestones.where((m) => m["status"] == "at_risk").length;
    int delayedMilestones = filteredMilestones.where((m) => m["status"] == "delayed").length;
    
    double avgProgress = totalMilestones > 0 
        ? filteredMilestones.map((m) => m["progress"] as int).reduce((a, b) => a + b) / totalMilestones 
        : 0.0;
    
    return Row(
      children: [
        Expanded(
          child: Container(
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
                  "Total Milestones",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "$totalMilestones",
                  style: TextStyle(
                    fontSize: fsH3,
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
                  "Completed",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "$completedMilestones",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: successColor,
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
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "At Risk",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "$atRiskMilestones",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
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
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Avg Progress",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${avgProgress.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildMilestoneCard(Map<String, dynamic> milestone) {
    Color statusColor = _getStatusColor(milestone["status"]);
    String statusLabel = _getStatusLabel(milestone["status"]);
    int progress = milestone["progress"];
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${milestone["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${milestone["project"]} • ${milestone["id"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
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
              SizedBox(width: spXs),
              Text(
                "${milestone["owner"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Due: ${milestone["due_date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progress",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "$progress%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: progress / 100,
                      backgroundColor: disabledColor.withAlpha(30),
                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                      minHeight: 4,
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
                child: Row(
                  children: [
                    Icon(
                      Icons.task_alt,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${milestone["tasks_completed"]}/${milestone["tasks_total"]} Tasks",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${milestone["actual_hours"]}/${milestone["planned_hours"]}h",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "\$${((milestone["spent"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (milestone["status"] == "at_risk" || milestone["status"] == "delayed") ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    size: 16,
                    color: statusColor,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      milestone["status"] == "at_risk" 
                          ? "Resource constraints may affect deadline"
                          : "Milestone is behind schedule - immediate action required",
                      style: TextStyle(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Milestone Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export report
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Section
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
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: projects,
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Timeframe",
                          items: timeframes,
                          value: selectedTimeframe,
                          onChanged: (value, label) {
                            selectedTimeframe = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Summary Cards
            _buildSummaryCards(),
            SizedBox(height: spMd),
            
            // Timeline Overview
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
                      Text(
                        "Milestone Timeline",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View Gantt Chart",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to Gantt chart view
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredMilestones.length,
                      itemBuilder: (context, index) {
                        final milestone = filteredMilestones[index];
                        Color statusColor = _getStatusColor(milestone["status"]);
                        
                        return Container(
                          width: 200,
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: statusColor.withAlpha(30)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${milestone["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${milestone["project"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Text(
                                    "Start:",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${milestone["start_date"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "Due:",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${milestone["due_date"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: statusColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              LinearProgressIndicator(
                                value: (milestone["progress"] as int) / 100,
                                backgroundColor: disabledColor.withAlpha(30),
                                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                                minHeight: 3,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${milestone["progress"]}% Complete",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Milestones List
            Row(
              children: [
                Text(
                  "Milestones (${filteredMilestones.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Add Milestone",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to create milestone
                  },
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            // Milestone Cards
            ...filteredMilestones.map((milestone) => _buildMilestoneCard(milestone)),
            
            if (filteredMilestones.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.flag,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No milestones found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or create a new milestone",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

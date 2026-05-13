import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaGanttChartView extends StatefulWidget {
  const PmaGanttChartView({super.key});

  @override
  State<PmaGanttChartView> createState() => _PmaGanttChartViewState();
}

class _PmaGanttChartViewState extends State<PmaGanttChartView> {
  String selectedProject = "E-commerce Platform";
  String selectedView = "Month";
  DateTime currentDate = DateTime.now();
  
  List<Map<String, dynamic>> projects = [
    {"label": "E-commerce Platform", "value": "ecommerce"},
    {"label": "Mobile App Redesign", "value": "mobile"},
    {"label": "Data Analytics Tool", "value": "analytics"},
    {"label": "CRM Integration", "value": "crm"},
  ];
  
  List<Map<String, dynamic>> viewOptions = [
    {"label": "Week", "value": "week"},
    {"label": "Month", "value": "month"},
    {"label": "Quarter", "value": "quarter"},
    {"label": "Year", "value": "year"},
  ];
  
  List<Map<String, dynamic>> tasks = [
    {
      "id": "T001",
      "name": "Project Setup & Planning",
      "start_date": DateTime(2024, 1, 15),
      "end_date": DateTime(2024, 1, 22),
      "progress": 100,
      "assigned_to": "John Smith",
      "priority": "high",
      "status": "completed",
      "dependencies": [],
      "milestone": "Project Initiation",
    },
    {
      "id": "T002",
      "name": "Database Design",
      "start_date": DateTime(2024, 1, 20),
      "end_date": DateTime(2024, 2, 5),
      "progress": 100,
      "assigned_to": "Sarah Johnson",
      "priority": "high",
      "status": "completed",
      "dependencies": ["T001"],
      "milestone": "Architecture Design",
    },
    {
      "id": "T003",
      "name": "User Authentication System",
      "start_date": DateTime(2024, 1, 25),
      "end_date": DateTime(2024, 2, 15),
      "progress": 100,
      "assigned_to": "Mike Wilson",
      "priority": "high",
      "status": "completed",
      "dependencies": ["T002"],
      "milestone": "Authentication",
    },
    {
      "id": "T004",
      "name": "Frontend UI Development",
      "start_date": DateTime(2024, 2, 1),
      "end_date": DateTime(2024, 2, 28),
      "progress": 85,
      "assigned_to": "Emily Davis",
      "priority": "high",
      "status": "in_progress",
      "dependencies": ["T002"],
      "milestone": "UI Components",
    },
    {
      "id": "T005",
      "name": "Product Catalog System",
      "start_date": DateTime(2024, 2, 10),
      "end_date": DateTime(2024, 3, 5),
      "progress": 60,
      "assigned_to": "David Brown",
      "priority": "medium",
      "status": "in_progress",
      "dependencies": ["T003"],
      "milestone": "Core Features",
    },
    {
      "id": "T006",
      "name": "Payment Gateway Integration",
      "start_date": DateTime(2024, 2, 15),
      "end_date": DateTime(2024, 3, 10),
      "progress": 40,
      "assigned_to": "Lisa Anderson",
      "priority": "high",
      "status": "in_progress",
      "dependencies": ["T003"],
      "milestone": "Payment System",
    },
    {
      "id": "T007",
      "name": "Shopping Cart Functionality",
      "start_date": DateTime(2024, 2, 20),
      "end_date": DateTime(2024, 3, 15),
      "progress": 25,
      "assigned_to": "Robert Taylor",
      "priority": "medium",
      "status": "in_progress",
      "dependencies": ["T004", "T005"],
      "milestone": "E-commerce Features",
    },
    {
      "id": "T008",
      "name": "Order Management System",
      "start_date": DateTime(2024, 3, 1),
      "end_date": DateTime(2024, 3, 25),
      "progress": 10,
      "assigned_to": "Jennifer White",
      "priority": "medium",
      "status": "pending",
      "dependencies": ["T006", "T007"],
      "milestone": "Order Processing",
    },
    {
      "id": "T009",
      "name": "Testing & Quality Assurance",
      "start_date": DateTime(2024, 3, 10),
      "end_date": DateTime(2024, 4, 5),
      "progress": 0,
      "assigned_to": "Mark Johnson",
      "priority": "high",
      "status": "pending",
      "dependencies": ["T007", "T008"],
      "milestone": "Testing Phase",
    },
    {
      "id": "T010",
      "name": "Deployment & Launch",
      "start_date": DateTime(2024, 4, 1),
      "end_date": DateTime(2024, 4, 15),
      "progress": 0,
      "assigned_to": "Team Lead",
      "priority": "high",
      "status": "pending",
      "dependencies": ["T009"],
      "milestone": "Project Launch",
    },
  ];
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return primaryColor;
      case "pending":
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
      case "in_progress":
        return "In Progress";
      case "pending":
        return "Pending";
      case "delayed":
        return "Delayed";
      default:
        return "Unknown";
    }
  }
  
  List<DateTime> _getTimelineHeaders() {
    List<DateTime> headers = [];
    DateTime start = DateTime(currentDate.year, currentDate.month, 1);
    
    if (selectedView == "month") {
      for (int i = 0; i < 30; i++) {
        headers.add(start.add(Duration(days: i)));
      }
    } else if (selectedView == "week") {
      DateTime weekStart = start.subtract(Duration(days: start.weekday - 1));
      for (int i = 0; i < 21; i++) {
        headers.add(weekStart.add(Duration(days: i)));
      }
    }
    
    return headers;
  }
  
  Widget _buildTimelineHeader() {
    List<DateTime> headers = _getTimelineHeaders();
    
    return Container(
      height: 60,
      child: Row(
        children: [
          Container(
            width: 200,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              border: Border.all(color: disabledColor.withAlpha(30)),
            ),
            child: Center(
              child: Text(
                "Tasks",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: headers.map((date) {
                  return Container(
                    width: selectedView == "month" ? 30 : 40,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledColor.withAlpha(30)),
                      color: date.weekday == DateTime.saturday || date.weekday == DateTime.sunday
                          ? disabledColor.withAlpha(10)
                          : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedView == "month" 
                              ? "${date.day}"
                              : ["", "M", "T", "W", "T", "F", "S", "S"][date.weekday],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        if (selectedView == "week") ...[
                          SizedBox(height: 2),
                          Text(
                            "${date.day}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTaskRow(Map<String, dynamic> task) {
    Color statusColor = _getStatusColor(task["status"]);
    List<DateTime> headers = _getTimelineHeaders();
    DateTime startDate = task["start_date"];
    DateTime endDate = task["end_date"];
    int progress = task["progress"];
    
    // Calculate position and width of the task bar
    double dayWidth = selectedView == "month" ? 30 : 40;
    double leftOffset = 0;
    double barWidth = 0;
    
    if (headers.isNotEmpty) {
      DateTime timelineStart = headers.first;
      DateTime timelineEnd = headers.last;
      
      if (startDate.isBefore(timelineEnd) && endDate.isAfter(timelineStart)) {
        int startDayIndex = startDate.difference(timelineStart).inDays;
        int endDayIndex = endDate.difference(timelineStart).inDays;
        
        startDayIndex = startDayIndex.clamp(0, headers.length - 1);
        endDayIndex = endDayIndex.clamp(0, headers.length - 1);
        
        leftOffset = startDayIndex * dayWidth;
        barWidth = (endDayIndex - startDayIndex + 1) * dayWidth;
      }
    }
    
    return Container(
      height: 50,
      child: Row(
        children: [
          Container(
            width: 200,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledColor.withAlpha(30)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${task["name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  "${task["assigned_to"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: headers.length * dayWidth,
                  child: Stack(
                    children: [
                      // Background grid
                      Row(
                        children: headers.map((date) {
                          return Container(
                            width: dayWidth,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledColor.withAlpha(30)),
                              color: date.weekday == DateTime.saturday || date.weekday == DateTime.sunday
                                  ? disabledColor.withAlpha(5)
                                  : Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                      // Task bar
                      if (barWidth > 0) ...[
                        Positioned(
                          left: leftOffset + 2,
                          top: 15,
                          child: Container(
                            width: barWidth - 4,
                            height: 20,
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: statusColor),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: (barWidth - 4) * (progress / 100),
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                                if (barWidth > 40) ...[
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        "$progress%",
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: progress > 50 ? Colors.white : statusColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLegend() {
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
            "Legend",
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
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 10,
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Completed",
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
                    Container(
                      width: 16,
                      height: 10,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "In Progress",
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
                    Container(
                      width: 16,
                      height: 10,
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Pending",
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
                    Container(
                      width: 16,
                      height: 10,
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Delayed",
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
        ],
      ),
    );
  }
  
  Widget _buildProjectSummary() {
    int totalTasks = tasks.length;
    int completedTasks = tasks.where((t) => t["status"] == "completed").length;
    int inProgressTasks = tasks.where((t) => t["status"] == "in_progress").length;
    int pendingTasks = tasks.where((t) => t["status"] == "pending").length;
    
    double overallProgress = totalTasks > 0 
        ? tasks.map((t) => t["progress"] as int).reduce((a, b) => a + b) / totalTasks 
        : 0.0;
    
    DateTime? projectStart = tasks.map((t) => t["start_date"] as DateTime).reduce((a, b) => a.isBefore(b) ? a : b);
    DateTime? projectEnd = tasks.map((t) => t["end_date"] as DateTime).reduce((a, b) => a.isAfter(b) ? a : b);
    
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
            "Project Summary",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Overall Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: overallProgress / 100,
                      backgroundColor: disabledColor.withAlpha(30),
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      minHeight: 6,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${overallProgress.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Timeline",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${projectStart.day}/${projectStart.month}/${projectStart.year}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.flag,
                          size: 14,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${projectEnd.day}/${projectEnd.month}/${projectEnd.year}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Task Status",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "✓ $completedTasks",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "⟳ $inProgressTasks",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "⏸ $pendingTasks",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gantt Chart"),
        actions: [
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: () {
              // Zoom in functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: () {
              // Zoom out functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              // Print/Export functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Controls Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
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
                      label: "View",
                      items: viewOptions,
                      value: selectedView,
                      onChanged: (value, label) {
                        selectedView = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.chevron_left),
                        onPressed: () {
                          setState(() {
                            if (selectedView == "month") {
                              currentDate = DateTime(currentDate.year, currentDate.month - 1, 1);
                            } else if (selectedView == "week") {
                              currentDate = currentDate.subtract(Duration(days: 7));
                            }
                          });
                        },
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          selectedView == "month" 
                              ? "${["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][currentDate.month]} ${currentDate.year}"
                              : "Week ${((currentDate.difference(DateTime(currentDate.year, 1, 1)).inDays) / 7).ceil()}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          setState(() {
                            if (selectedView == "month") {
                              currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
                            } else if (selectedView == "week") {
                              currentDate = currentDate.add(Duration(days: 7));
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Project Summary
            _buildProjectSummary(),
            SizedBox(height: spMd),
            
            // Legend
            _buildLegend(),
            SizedBox(height: spMd),
            
            // Gantt Chart
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Text(
                          "Project Timeline",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Full Screen",
                          size: bs.sm,
                          onPressed: () {
                            // Full screen mode
                          },
                        ),
                      ],
                    ),
                  ),
                  // Timeline Header
                  _buildTimelineHeader(),
                  // Task Rows
                  Column(
                    children: tasks.map((task) => _buildTaskRow(task)).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Critical Path Analysis
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
                    "Critical Path Analysis",
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
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: dangerColor.withAlpha(30)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    size: 16,
                                    color: dangerColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Critical Tasks",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "• Payment Gateway Integration\n• Shopping Cart Functionality\n• Order Management System",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: dangerColor,
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
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: warningColor.withAlpha(30)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Project Duration",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "90 days total\n75 days remaining\n83% completion rate",
                                style: TextStyle(
                                  fontSize: 11,
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
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: primaryColor.withAlpha(30)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Resource Utilization",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "8 team members\n85% capacity\nNo overallocation",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProgress7View extends StatefulWidget {
  @override
  State<GrlProgress7View> createState() => _GrlProgress7ViewState();
}

class _GrlProgress7ViewState extends State<GrlProgress7View> {
  int currentStep = 2;
  String selectedTimeframe = "monthly";

  List<Map<String, dynamic>> timeframes = [
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> progressSteps = [
    {
      "title": "Project Planning",
      "description": "Define objectives, scope, and requirements",
      "status": "completed",
      "completedDate": "2024-01-15",
      "tasks": [
        {"name": "Requirements gathering", "completed": true},
        {"name": "Resource allocation", "completed": true},
        {"name": "Timeline creation", "completed": true},
      ]
    },
    {
      "title": "Design Phase",
      "description": "Create wireframes, mockups, and prototypes",
      "status": "completed",
      "completedDate": "2024-01-28",
      "tasks": [
        {"name": "User research", "completed": true},
        {"name": "Wireframe design", "completed": true},
        {"name": "UI/UX design", "completed": true},
        {"name": "Prototype development", "completed": true},
      ]
    },
    {
      "title": "Development",
      "description": "Build core functionality and features",
      "status": "in_progress",
      "completedDate": null,
      "progress": 65,
      "tasks": [
        {"name": "Backend setup", "completed": true},
        {"name": "Database design", "completed": true},
        {"name": "Frontend development", "completed": false},
        {"name": "API integration", "completed": false},
        {"name": "Testing implementation", "completed": false},
      ]
    },
    {
      "title": "Quality Assurance",
      "description": "Testing, bug fixes, and optimization",
      "status": "pending",
      "completedDate": null,
      "tasks": [
        {"name": "Unit testing", "completed": false},
        {"name": "Integration testing", "completed": false},
        {"name": "User acceptance testing", "completed": false},
        {"name": "Performance optimization", "completed": false},
      ]
    },
    {
      "title": "Deployment",
      "description": "Launch and monitor the application",
      "status": "pending",
      "completedDate": null,
      "tasks": [
        {"name": "Production setup", "completed": false},
        {"name": "Data migration", "completed": false},
        {"name": "Go-live", "completed": false},
        {"name": "Post-launch monitoring", "completed": false},
      ]
    },
  ];

  Map<String, List<Map<String, dynamic>>> achievementData = {
    "weekly": [
      {"title": "Tasks Completed", "value": 12, "target": 15, "change": 3},
      {"title": "Hours Worked", "value": 38, "target": 40, "change": -2},
      {"title": "Meetings Attended", "value": 8, "target": 6, "change": 2},
    ],
    "monthly": [
      {"title": "Projects Delivered", "value": 3, "target": 4, "change": 1},
      {"title": "Client Satisfaction", "value": 94, "target": 90, "change": 4},
      {"title": "Team Collaboration", "value": 88, "target": 85, "change": 3},
    ],
    "quarterly": [
      {"title": "Revenue Growth", "value": 15, "target": 12, "change": 3},
      {"title": "Market Expansion", "value": 8, "target": 10, "change": -2},
      {"title": "Team Size", "value": 25, "target": 30, "change": 5},
    ],
    "yearly": [
      {"title": "Annual Goals Met", "value": 8, "target": 10, "change": 2},
      {"title": "Skills Acquired", "value": 15, "target": 12, "change": 3},
      {"title": "Certifications", "value": 4, "target": 5, "change": 1},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final achievements = achievementData[selectedTimeframe] ?? [];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Overall Progress Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Overall Progress",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${_calculateOverallProgress().toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  
                  LinearProgressIndicator(
                    value: _calculateOverallProgress() / 100,
                    backgroundColor: Colors.white.withAlpha(60),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 8,
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Step ${currentStep + 1} of ${progressSteps.length}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${progressSteps.where((step) => step["status"] == "completed").length} completed",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Progress Steps
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Project Milestones",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Column(
                    children: List.generate(
                      progressSteps.length,
                      (index) => _buildProgressStep(progressSteps[index], index),
                    ),
                  ),
                ],
              ),
            ),

            // Achievement Metrics
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Performance Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                QDropdownField(
                  label: "Timeframe",
                  items: timeframes,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: achievements.map((achievement) {
                    return _buildMetricCard(achievement);
                  }).toList(),
                ),
              ],
            ),

            // Current Step Details
            if (currentStep < progressSteps.length)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(color: primaryColor, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.play_circle,
                          color: primaryColor,
                          size: 28,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Currently Working On",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    _buildCurrentStepDetails(progressSteps[currentStep]),
                  ],
                ),
              ),

            // Progress Timeline
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Progress Timeline",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Container(
                    height: 100,
                    child: _buildTimelineChart(),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Update Progress",
                    icon: Icons.edit,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "View Report",
                    icon: Icons.analytics,
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

  Widget _buildProgressStep(Map<String, dynamic> step, int index) {
    final isCompleted = step["status"] == "completed";
    final isInProgress = step["status"] == "in_progress";
    final isPending = step["status"] == "pending";
    
    Color statusColor = disabledBoldColor;
    IconData statusIcon = Icons.circle;
    
    if (isCompleted) {
      statusColor = successColor;
      statusIcon = Icons.check_circle;
    } else if (isInProgress) {
      statusColor = warningColor;
      statusIcon = Icons.play_circle;
    } else if (isPending) {
      statusColor = disabledBoldColor;
      statusIcon = Icons.radio_button_unchecked;
    }

    return Container(
      margin: EdgeInsets.only(bottom: index < progressSteps.length - 1 ? spMd : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Indicator
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  shape: BoxShape.circle,
                  border: Border.all(color: statusColor, width: 2),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 20,
                ),
              ),
              if (index < progressSteps.length - 1)
                Container(
                  width: 2,
                  height: 40,
                  color: statusColor.withAlpha(60),
                ),
            ],
          ),
          
          SizedBox(width: spMd),
          
          // Step Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${step["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: isCompleted ? disabledBoldColor : primaryColor,
                        ),
                      ),
                    ),
                    if (isInProgress && step["progress"] != null)
                      Text(
                        "${step["progress"]}%",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                  ],
                ),
                
                Text(
                  "${step["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                
                if (step["completedDate"] != null)
                  Text(
                    "Completed: ${DateTime.parse(step["completedDate"]).day}/${DateTime.parse(step["completedDate"]).month}/${DateTime.parse(step["completedDate"]).year}",
                    style: TextStyle(
                      color: successColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                
                if (isInProgress && step["progress"] != null)
                  Container(
                    margin: EdgeInsets.only(top: spXs),
                    child: LinearProgressIndicator(
                      value: (step["progress"] as num) / 100,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                      minHeight: 4,
                    ),
                  ),
                
                // Task Count
                Text(
                  "${(step["tasks"] as List).where((task) => task["completed"]).length}/${(step["tasks"] as List).length} tasks completed",
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
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    final progress = ((metric["value"] as num) / (metric["target"] as num) * 100).clamp(0.0, 100.0);
    final change = metric["change"] as num;
    final isPositive = change >= 0;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          
          Row(
            children: [
              Text(
                "${metric["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                " / ${metric["target"]}",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      size: 12,
                      color: isPositive ? successColor : dangerColor,
                    ),
                    Text(
                      "${change.abs()}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isPositive ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            minHeight: 6,
          ),
          
          Text(
            "${progress.toStringAsFixed(0)}% of target",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStepDetails(Map<String, dynamic> step) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "${step["title"]}",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        Text(
          "${step["description"]}",
          style: TextStyle(
            color: disabledBoldColor,
          ),
        ),
        
        if (step["progress"] != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Progress",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${step["progress"]}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: (step["progress"] as num) / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                minHeight: 8,
              ),
            ],
          ),
        
        Text(
          "Tasks (${(step["tasks"] as List).where((task) => task["completed"]).length}/${(step["tasks"] as List).length})",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        
        Column(
          spacing: spXs,
          children: List.generate(
            (step["tasks"] as List).length,
            (index) {
              final task = (step["tasks"] as List)[index];
              return Row(
                children: [
                  Icon(
                    task["completed"] ? Icons.check_circle : Icons.radio_button_unchecked,
                    size: 16,
                    color: task["completed"] ? successColor : disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${task["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: task["completed"] ? disabledBoldColor : primaryColor,
                        decoration: task["completed"] ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(progressSteps.length, (index) {
          final step = progressSteps[index];
          final isCompleted = step["status"] == "completed";
          final isInProgress = step["status"] == "in_progress";
          
          double height = 20;
          Color color = disabledBoldColor;
          
          if (isCompleted) {
            height = 60;
            color = successColor;
          } else if (isInProgress) {
            height = 40;
            color = warningColor;
          }
          
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 30,
                height: height,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Step ${index + 1}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  double _calculateOverallProgress() {
    final completedSteps = progressSteps.where((step) => step["status"] == "completed").length;
    final inProgressSteps = progressSteps.where((step) => step["status"] == "in_progress");
    
    double progress = (completedSteps / progressSteps.length) * 100;
    
    for (var step in inProgressSteps) {
      if (step["progress"] != null) {
        progress += ((step["progress"] as num) / progressSteps.length);
      }
    }
    
    return progress.clamp(0.0, 100.0);
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProductivityReportsView extends StatefulWidget {
  const ComaProductivityReportsView({super.key});

  @override
  State<ComaProductivityReportsView> createState() => _ComaProductivityReportsViewState();
}

class _ComaProductivityReportsViewState extends State<ComaProductivityReportsView> {
  String selectedPeriod = "This Month";
  String selectedProject = "All Projects";
  String selectedMetric = "All Metrics";

  List<Map<String, dynamic>> productivityData = [
    {
      "project": "Highway Extension Project",
      "manager": "John Peterson",
      "period": "December 2024",
      "metrics": {
        "tasksCompleted": 31,
        "tasksTotal": 45,
        "hoursWorked": 1240,
        "hoursPlanned": 1300,
        "efficiency": 87.5,
        "quality": 94.2,
        "onTimeDelivery": 89.3,
        "resourceUtilization": 95.4
      },
      "equipment": [
        {"name": "Excavator CAT 320D2", "productivity": 94.2, "hours": 156.5},
        {"name": "Dump Truck DT-40", "productivity": 91.8, "hours": 178.5},
        {"name": "Compactor RC-25", "productivity": 93.5, "hours": 134.0}
      ],
      "milestones": [
        {"name": "Foundation Work", "status": "Completed", "efficiency": 96.5},
        {"name": "Road Surface", "status": "In Progress", "efficiency": 87.2}
      ],
      "cost": {
        "budget": 125000.00,
        "actual": 132000.00,
        "variance": 7000.00
      }
    },
    {
      "project": "Shopping Mall Construction",
      "manager": "Sarah Mitchell",
      "period": "December 2024",
      "metrics": {
        "tasksCompleted": 33,
        "tasksTotal": 78,
        "hoursWorked": 2150,
        "hoursPlanned": 2200,
        "efficiency": 92.1,
        "quality": 96.8,
        "onTimeDelivery": 91.7,
        "resourceUtilization": 97.7
      },
      "equipment": [
        {"name": "Crane Tower CT-250", "productivity": 96.5, "hours": 142.0},
        {"name": "Bulldozer D6T", "productivity": 79.3, "hours": 120.0},
        {"name": "Concrete Mixer CM-500", "productivity": 85.4, "hours": 98.5}
      ],
      "milestones": [
        {"name": "Foundation & Basement", "status": "Completed", "efficiency": 94.3},
        {"name": "Structural Steel", "status": "In Progress", "efficiency": 89.7}
      ],
      "cost": {
        "budget": 245000.00,
        "actual": 238000.00,
        "variance": -7000.00
      }
    },
    {
      "project": "Residential Complex Phase 1",
      "manager": "Michael Rodriguez",
      "period": "December 2024",
      "metrics": {
        "tasksCompleted": 39,
        "tasksTotal": 52,
        "hoursWorked": 1580,
        "hoursPlanned": 1600,
        "efficiency": 95.2,
        "quality": 92.7,
        "onTimeDelivery": 94.1,
        "resourceUtilization": 98.8
      },
      "equipment": [
        {"name": "Excavator CAT 320D2", "productivity": 97.3, "hours": 89.5},
        {"name": "Compactor RC-25", "productivity": 94.8, "hours": 76.0}
      ],
      "milestones": [
        {"name": "Building Construction", "status": "Completed", "efficiency": 97.1},
        {"name": "Utilities Installation", "status": "In Progress", "efficiency": 91.5}
      ],
      "cost": {
        "budget": 180000.00,
        "actual": 175000.00,
        "variance": -5000.00
      }
    }
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"}
  ];

  List<Map<String, dynamic>> projectOptions = [
    {"label": "All Projects", "value": "All Projects"},
    {"label": "Highway Extension Project", "value": "Highway Extension Project"},
    {"label": "Shopping Mall Construction", "value": "Shopping Mall Construction"},
    {"label": "Residential Complex Phase 1", "value": "Residential Complex Phase 1"}
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "All Metrics", "value": "All Metrics"},
    {"label": "Efficiency", "value": "Efficiency"},
    {"label": "Quality", "value": "Quality"},
    {"label": "On-Time Delivery", "value": "On-Time Delivery"},
    {"label": "Resource Utilization", "value": "Resource Utilization"}
  ];

  List<Map<String, dynamic>> get filteredProjects {
    return productivityData.where((project) {
      bool matchesProject = selectedProject == "All Projects" || 
          "${project["project"]}" == selectedProject;
      
      return matchesProject;
    }).toList();
  }

  Color _getPerformanceColor(double value) {
    if (value >= 95) return successColor;
    if (value >= 85) return primaryColor;
    if (value >= 75) return warningColor;
    return dangerColor;
  }

  Color _getVarianceColor(double variance) {
    if (variance > 0) return dangerColor;
    if (variance < 0) return successColor;
    return primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    double avgEfficiency = filteredProjects.fold(0.0, (sum, p) => sum + ((p["metrics"] as Map)["efficiency"] as num).toDouble()) / filteredProjects.length;
    double avgQuality = filteredProjects.fold(0.0, (sum, p) => sum + ((p["metrics"] as Map)["quality"] as num).toDouble()) / filteredProjects.length;
    double avgOnTime = filteredProjects.fold(0.0, (sum, p) => sum + ((p["metrics"] as Map)["onTimeDelivery"] as num).toDouble()) / filteredProjects.length;
    double totalBudget = filteredProjects.fold(0.0, (sum, p) => sum + ((p["cost"] as Map)["budget"] as num).toDouble());
    double totalActual = filteredProjects.fold(0.0, (sum, p) => sum + ((p["cost"] as Map)["actual"] as num).toDouble());

    return Scaffold(
      appBar: AppBar(
        title: Text("Productivity Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QDropdownField(
                    label: "Report Period",
                    items: periodOptions,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: projectOptions,
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
                          label: "Focus Metric",
                          items: metricOptions,
                          value: selectedMetric,
                          onChanged: (value, label) {
                            selectedMetric = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Executive Summary
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
                    "Executive Summary",
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
                          children: [
                            Icon(Icons.trending_up, color: successColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "${avgEfficiency.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Avg Efficiency",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.star, color: primaryColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "${avgQuality.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Avg Quality",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.schedule, color: infoColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "${avgOnTime.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "On-Time Delivery",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.attach_money, color: warningColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "${((totalActual / totalBudget) * 100).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Budget Usage",
                              textAlign: TextAlign.center,
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
            ),

            // Project Reports
            ...filteredProjects.map((project) {
              final metrics = project["metrics"] as Map<String, dynamic>;
              final equipment = project["equipment"] as List;
              final milestones = project["milestones"] as List;
              final cost = project["cost"] as Map<String, dynamic>;

              double taskCompletion = ((metrics["tasksCompleted"] as num).toDouble() / (metrics["tasksTotal"] as num).toDouble()) * 100;
              double hoursEfficiency = ((metrics["hoursWorked"] as num).toDouble() / (metrics["hoursPlanned"] as num).toDouble()) * 100;

              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getPerformanceColor((metrics["efficiency"] as num).toDouble()),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${project["project"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.person, size: 12, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${project["manager"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.calendar_today, size: 12, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${project["period"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getPerformanceColor((metrics["efficiency"] as num).toDouble()).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(metrics["efficiency"] as num).toStringAsFixed(1)}% Efficient",
                            style: TextStyle(
                              fontSize: 11,
                              color: _getPerformanceColor((metrics["efficiency"] as num).toDouble()),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Key Metrics Grid
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${(metrics["quality"] as num).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: _getPerformanceColor((metrics["quality"] as num).toDouble()),
                                  ),
                                ),
                                Text(
                                  "Quality Score",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${(metrics["onTimeDelivery"] as num).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: _getPerformanceColor((metrics["onTimeDelivery"] as num).toDouble()),
                                  ),
                                ),
                                Text(
                                  "On-Time",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${(metrics["resourceUtilization"] as num).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: _getPerformanceColor((metrics["resourceUtilization"] as num).toDouble()),
                                  ),
                                ),
                                Text(
                                  "Resource Use",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${taskCompletion.toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: _getPerformanceColor(taskCompletion),
                                  ),
                                ),
                                Text(
                                  "Task Progress",
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
                    ),

                    SizedBox(height: spSm),

                    // Tasks and Hours Progress
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tasks Completed",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${metrics["tasksCompleted"]} / ${metrics["tasksTotal"]} tasks",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: taskCompletion / 100,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _getPerformanceColor(taskCompletion),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
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
                                "Hours Efficiency",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${metrics["hoursWorked"]}h / ${metrics["hoursPlanned"]}h",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: (hoursEfficiency / 100).clamp(0.0, 1.0),
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: hoursEfficiency <= 100 ? successColor : warningColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Equipment Performance
                    if (equipment.isNotEmpty) ...[
                      Text(
                        "Equipment Performance",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...equipment.take(3).map((equip) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(3),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${equip["name"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${(equip["productivity"] as num).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: _getPerformanceColor((equip["productivity"] as num).toDouble()),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(equip["hours"] as num).toStringAsFixed(1)}h",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],

                    SizedBox(height: spSm),

                    // Cost Performance
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Budget Performance",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Budget: \$${((cost["budget"] as num).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Actual: \$${((cost["actual"] as num).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getVarianceColor((cost["variance"] as num).toDouble()).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(cost["variance"] as num) >= 0 ? '+' : ''}\$${((cost["variance"] as num).toDouble().abs()).currency}",
                            style: TextStyle(
                              fontSize: 11,
                              color: _getVarianceColor((cost["variance"] as num).toDouble()),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Detailed Report",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

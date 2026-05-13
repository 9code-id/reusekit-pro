import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaHealthSafetyView extends StatefulWidget {
  const RmaHealthSafetyView({super.key});

  @override
  State<RmaHealthSafetyView> createState() => _RmaHealthSafetyViewState();
}

class _RmaHealthSafetyViewState extends State<RmaHealthSafetyView> {
  String selectedTimeRange = "This Month";
  String selectedDepartment = "All Departments";
  String selectedLocation = "All Locations";
  String selectedIncidentType = "All Types";

  final List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  final List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Manufacturing", "value": "Manufacturing"},
    {"label": "Quality Control", "value": "Quality Control"},
    {"label": "Warehouse", "value": "Warehouse"},
    {"label": "Research & Development", "value": "Research & Development"},
    {"label": "Administration", "value": "Administration"},
  ];

  final List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "All Locations"},
    {"label": "Main Facility", "value": "Main Facility"},
    {"label": "Warehouse A", "value": "Warehouse A"},
    {"label": "Warehouse B", "value": "Warehouse B"},
    {"label": "Research Lab", "value": "Research Lab"},
    {"label": "Office Building", "value": "Office Building"},
  ];

  final List<Map<String, dynamic>> incidentTypeOptions = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Injury", "value": "Injury"},
    {"label": "Near Miss", "value": "Near Miss"},
    {"label": "Equipment Failure", "value": "Equipment Failure"},
    {"label": "Chemical Spill", "value": "Chemical Spill"},
    {"label": "Fire/Explosion", "value": "Fire/Explosion"},
  ];

  final List<Map<String, dynamic>> safetyMetrics = [
    {
      "title": "Days Without Incident",
      "value": "127",
      "icon": Icons.shield_outlined,
      "color": "#10B981",
      "trend": "+12 days",
      "description": "Best performance this year"
    },
    {
      "title": "Safety Score",
      "value": "98.5%",
      "icon": Icons.security,
      "color": "#06B6D4",
      "trend": "+2.1%",
      "description": "Industry leading score"
    },
    {
      "title": "Total Incidents",
      "value": "3",
      "icon": Icons.warning,
      "color": "#F59E0B",
      "trend": "-5 incidents",
      "description": "Lowest this quarter"
    },
    {
      "title": "Near Misses",
      "value": "12",
      "icon": Icons.visibility,
      "color": "#8B5CF6",
      "trend": "+2 reports",
      "description": "Proactive reporting up"
    },
    {
      "title": "Training Compliance",
      "value": "96.8%",
      "icon": Icons.school,
      "color": "#10B981",
      "trend": "+3.2%",
      "description": "On schedule completion"
    },
    {
      "title": "PPE Compliance",
      "value": "99.1%",
      "icon": Icons.health_and_safety,
      "color": "#06B6D4",
      "trend": "+1.5%",
      "description": "Excellent adherence"
    },
  ];

  final List<Map<String, dynamic>> recentIncidents = [
    {
      "id": "INC-2024-001",
      "type": "Near Miss",
      "title": "Forklift Near Collision",
      "location": "Warehouse A",
      "department": "Warehouse",
      "reportedBy": "John Smith",
      "date": "2024-01-15",
      "severity": "Low",
      "status": "Investigated",
      "description": "Forklift operator failed to see pedestrian in blind spot"
    },
    {
      "id": "INC-2024-002",
      "type": "Injury",
      "title": "Minor Cut on Hand",
      "location": "Manufacturing",
      "department": "Manufacturing",
      "reportedBy": "Sarah Johnson",
      "date": "2024-01-12",
      "severity": "Minor",
      "status": "Closed",
      "description": "Employee cut hand on metal edge while handling materials"
    },
    {
      "id": "INC-2024-003",
      "type": "Equipment Failure",
      "title": "Safety Guard Malfunction",
      "location": "Main Facility",
      "department": "Manufacturing",
      "reportedBy": "Mike Wilson",
      "date": "2024-01-10",
      "severity": "Medium",
      "status": "Under Review",
      "description": "Safety guard on machine failed to activate properly"
    },
    {
      "id": "INC-2024-004",
      "type": "Near Miss",
      "title": "Chemical Container Leak",
      "location": "Research Lab",
      "department": "Research & Development",
      "reportedBy": "Dr. Emily Chen",
      "date": "2024-01-08",
      "severity": "Medium",
      "status": "Resolved",
      "description": "Small leak detected in chemical storage container"
    },
  ];

  final List<Map<String, dynamic>> safetyTraining = [
    {
      "course": "Basic Safety Orientation",
      "totalEmployees": 150,
      "completed": 145,
      "inProgress": 3,
      "overdue": 2,
      "completionRate": "96.7%",
      "dueDate": "2024-02-01"
    },
    {
      "course": "Chemical Handling Safety",
      "totalEmployees": 45,
      "completed": 42,
      "inProgress": 2,
      "overdue": 1,
      "completionRate": "93.3%",
      "dueDate": "2024-02-15"
    },
    {
      "course": "Equipment Operation Safety",
      "totalEmployees": 78,
      "completed": 76,
      "inProgress": 1,
      "overdue": 1,
      "completionRate": "97.4%",
      "dueDate": "2024-02-10"
    },
    {
      "course": "Emergency Response Procedures",
      "totalEmployees": 150,
      "completed": 147,
      "inProgress": 2,
      "overdue": 1,
      "completionRate": "98.0%",
      "dueDate": "2024-03-01"
    },
  ];

  final List<Map<String, dynamic>> safetyInspections = [
    {
      "area": "Manufacturing Floor",
      "lastInspection": "2024-01-20",
      "nextDue": "2024-02-20",
      "inspector": "Safety Officer A",
      "score": "95%",
      "findings": "2 Minor",
      "status": "Passed"
    },
    {
      "area": "Chemical Storage",
      "lastInspection": "2024-01-18",
      "nextDue": "2024-02-18",
      "inspector": "Safety Officer B",
      "score": "98%",
      "findings": "1 Minor",
      "status": "Passed"
    },
    {
      "area": "Emergency Exits",
      "lastInspection": "2024-01-15",
      "nextDue": "2024-02-15",
      "inspector": "Fire Marshal",
      "score": "100%",
      "findings": "None",
      "status": "Passed"
    },
    {
      "area": "Equipment Safety",
      "lastInspection": "2024-01-22",
      "nextDue": "2024-02-22",
      "inspector": "Technical Inspector",
      "score": "92%",
      "findings": "3 Minor",
      "status": "Conditional"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RMA Health & Safety"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              ss("Safety report exported");
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              ss("New incident report created");
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Safety Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Time Range",
                          items: timeRangeOptions,
                          value: selectedTimeRange,
                          onChanged: (value, label) {
                            selectedTimeRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Department",
                          items: departmentOptions,
                          value: selectedDepartment,
                          onChanged: (value, label) {
                            selectedDepartment = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Location",
                          items: locationOptions,
                          value: selectedLocation,
                          onChanged: (value, label) {
                            selectedLocation = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Incident Type",
                          items: incidentTypeOptions,
                          value: selectedIncidentType,
                          onChanged: (value, label) {
                            selectedIncidentType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Safety Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: safetyMetrics.map((metric) {
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
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Color(int.parse("0xFF${(metric["color"] as String).substring(1)}")),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${metric["trend"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${metric["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Incidents
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.report_problem, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Incidents",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: recentIncidents.map((incident) {
                      Color typeColor = incident["type"] == "Injury" 
                          ? dangerColor 
                          : incident["type"] == "Near Miss"
                              ? warningColor
                              : incident["type"] == "Equipment Failure"
                                  ? infoColor
                                  : primaryColor;

                      Color severityColor = incident["severity"] == "High" 
                          ? dangerColor 
                          : incident["severity"] == "Medium"
                              ? warningColor
                              : successColor;

                      Color statusColor = incident["status"] == "Closed" 
                          ? successColor 
                          : incident["status"] == "Under Review"
                              ? warningColor
                              : incident["status"] == "Resolved"
                                  ? infoColor
                                  : primaryColor;

                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${incident["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: typeColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${incident["type"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: typeColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${incident["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${incident["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${incident["location"]}",
                                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.business, size: 14, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${incident["department"]}",
                                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person, size: 14, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${incident["reportedBy"]}",
                                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${incident["date"]}",
                                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: severityColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Severity: ${incident["severity"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: severityColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${incident["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
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

            // Safety Training
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.school, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Safety Training Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Schedule Training",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: safetyTraining.map((training) {
                      double progress = (training["completed"] as int) / (training["totalEmployees"] as int);
                      bool isOverdue = (training["overdue"] as int) > 0;

                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${training["course"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: isOverdue ? dangerColor.withAlpha(20) : successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${training["completionRate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isOverdue ? dangerColor : successColor,
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
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        "Total Employees: ${training["totalEmployees"]}",
                                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                      ),
                                      Text(
                                        "Completed: ${training["completed"]}",
                                        style: TextStyle(fontSize: 12, color: successColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        "In Progress: ${training["inProgress"]}",
                                        style: TextStyle(fontSize: 12, color: warningColor),
                                      ),
                                      Text(
                                        "Overdue: ${training["overdue"]}",
                                        style: TextStyle(fontSize: 12, color: dangerColor),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Progress",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Due: ${training["dueDate"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: (progress * 100).round(),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: isOverdue ? dangerColor : successColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: ((1 - progress) * 100).round(),
                                        child: Container(),
                                      ),
                                    ],
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

            // Safety Inspections
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.checklist, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Safety Inspections",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Schedule Inspection",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: safetyInspections.map((inspection) {
                      Color statusColor = inspection["status"] == "Passed" 
                          ? successColor 
                          : inspection["status"] == "Conditional"
                              ? warningColor
                              : dangerColor;

                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${inspection["area"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${inspection["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
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
                                    spacing: spXs,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Last: ${inspection["lastInspection"]}",
                                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.person, size: 14, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${inspection["inspector"]}",
                                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Next: ${inspection["nextDue"]}",
                                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.grade, size: 14, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Score: ${inspection["score"]}",
                                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.warning, size: 14, color: warningColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Findings: ${inspection["findings"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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

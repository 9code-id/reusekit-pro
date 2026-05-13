import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaCaregiverDashboardView extends StatefulWidget {
  const HcaCaregiverDashboardView({super.key});

  @override
  State<HcaCaregiverDashboardView> createState() => _HcaCaregiverDashboardViewState();
}

class _HcaCaregiverDashboardViewState extends State<HcaCaregiverDashboardView> {
  String selectedDate = DateTime.now().toString().split(' ')[0];
  
  List<Map<String, dynamic>> todayPatients = [
    {
      "name": "Margaret Johnson",
      "age": 82,
      "time": "8:00 AM - 12:00 PM",
      "address": "123 Oak Street",
      "tasks": 5,
      "completed": 3,
      "priority": "high",
      "conditions": ["Diabetes", "Hypertension"],
      "photo": "https://picsum.photos/60/60?random=1&keyword=elderly"
    },
    {
      "name": "Robert Wilson",
      "age": 78,
      "time": "1:00 PM - 5:00 PM",
      "address": "456 Pine Avenue",
      "tasks": 4,
      "completed": 4,
      "priority": "medium",
      "conditions": ["Arthritis"],
      "photo": "https://picsum.photos/60/60?random=2&keyword=senior"
    },
    {
      "name": "Dorothy Brown",
      "age": 85,
      "time": "6:00 PM - 9:00 PM",
      "address": "789 Maple Drive",
      "tasks": 3,
      "completed": 0,
      "priority": "high",
      "conditions": ["Alzheimer's", "Heart Disease"],
      "photo": "https://picsum.photos/60/60?random=3&keyword=grandmother"
    },
  ];
  
  List<Map<String, dynamic>> quickStats = [
    {
      "title": "Today's Patients",
      "value": "3",
      "icon": Icons.people,
      "color": primaryColor,
      "trend": "+5%"
    },
    {
      "title": "Tasks Completed",
      "value": "7/12",
      "icon": Icons.task_alt,
      "color": successColor,
      "trend": "58%"
    },
    {
      "title": "Hours Worked",
      "value": "6.5",
      "icon": Icons.access_time,
      "color": infoColor,
      "trend": "+2h"
    },
    {
      "title": "Alerts",
      "value": "2",
      "icon": Icons.warning,
      "color": warningColor,
      "trend": "New"
    },
  ];
  
  List<Map<String, dynamic>> recentActivity = [
    {
      "time": "2:45 PM",
      "patient": "Robert Wilson",
      "activity": "Medication administered",
      "type": "medication",
      "notes": "Blood pressure medication taken with lunch"
    },
    {
      "time": "2:30 PM",
      "patient": "Robert Wilson",
      "activity": "Vital signs recorded",
      "type": "vitals",
      "notes": "BP: 125/80, HR: 72, Temp: 98.6°F"
    },
    {
      "time": "11:30 AM",
      "patient": "Margaret Johnson",
      "activity": "Physical therapy completed",
      "type": "therapy",
      "notes": "Mobility exercises, good progress"
    },
    {
      "time": "10:15 AM",
      "patient": "Margaret Johnson",
      "activity": "Blood sugar check",
      "type": "vitals",
      "notes": "Glucose level: 110 mg/dL - Normal"
    },
  ];
  
  List<Map<String, dynamic>> upcomingTasks = [
    {
      "time": "6:00 PM",
      "patient": "Dorothy Brown",
      "task": "Evening medication",
      "priority": "high",
      "type": "medication"
    },
    {
      "time": "6:30 PM",
      "patient": "Dorothy Brown",
      "task": "Dinner assistance",
      "priority": "medium",
      "type": "care"
    },
    {
      "time": "7:00 PM",
      "patient": "Dorothy Brown",
      "task": "Evening vitals check",
      "priority": "high",
      "type": "vitals"
    },
  ];
  
  List<Map<String, dynamic>> notifications = [
    {
      "title": "Medication Reminder",
      "message": "Dorothy Brown - Evening meds due in 30 minutes",
      "time": "5:30 PM",
      "type": "reminder",
      "priority": "high"
    },
    {
      "title": "Schedule Update",
      "message": "Tomorrow's appointment with Dr. Miller moved to 3:00 PM",
      "time": "3:15 PM",
      "type": "schedule",
      "priority": "medium"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caregiver Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              _showNotificationsDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.emergency),
            onPressed: () {
              _showEmergencyDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSelector(),
            _buildQuickStats(),
            _buildTodayPatients(),
            _buildUpcomingTasks(),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: QDatePicker(
        label: "Select Date",
        value: DateTime.parse(selectedDate),
        onChanged: (value) {
          selectedDate = value.toString().split(' ')[0];
          setState(() {});
        },
      ),
    );
  }

  Widget _buildQuickStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: quickStats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
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
                  color: (stat["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"] as Color,
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${stat["trend"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: stat["color"] as Color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: stat["color"] as Color,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayPatients() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.people,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Today's Patients",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...todayPatients.map((patient) => _buildPatientCard(patient)),
        ],
      ),
    );
  }

  Widget _buildPatientCard(Map<String, dynamic> patient) {
    Color priorityColor = _getPriorityColor(patient["priority"]);
    double completionRate = (patient["completed"] as int) / (patient["tasks"] as int);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: priorityColor.withAlpha(100)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${patient["photo"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${patient["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${patient["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: priorityColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Age ${patient["age"]} • ${patient["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${patient["address"]}",
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Conditions:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(patient["conditions"] as List).join(", ")}",
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
                    "Tasks: ${patient["completed"]}/${patient["tasks"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: completionRate,
                      child: Container(
                        decoration: BoxDecoration(
                          color: completionRate == 1.0 ? successColor : primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    _showPatientDetailsDialog(patient);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Note",
                  size: bs.sm,
                  onPressed: () {
                    _showAddNoteDialog(patient["name"]);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTasks() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Upcoming Tasks",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...upcomingTasks.map((task) => _buildUpcomingTaskItem(task)),
        ],
      ),
    );
  }

  Widget _buildUpcomingTaskItem(Map<String, dynamic> task) {
    Color taskColor = _getTaskTypeColor(task["type"]);
    Color priorityColor = _getPriorityColor(task["priority"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: taskColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: priorityColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: taskColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getTaskTypeIcon(task["type"]),
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${task["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: taskColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${task["priority"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: priorityColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${task["task"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${task["patient"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Complete",
            size: bs.sm,
            onPressed: () {
              ss("Task marked as completed");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...recentActivity.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color activityColor = _getTaskTypeColor(activity["type"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: activityColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${activity["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: activityColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${activity["patient"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${activity["activity"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (activity["notes"] != null) ...[
                  Text(
                    "${activity["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTaskTypeColor(String type) {
    switch (type) {
      case "medication":
        return primaryColor;
      case "vitals":
        return successColor;
      case "care":
        return warningColor;
      case "therapy":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTaskTypeIcon(String type) {
    switch (type) {
      case "medication":
        return Icons.medication;
      case "vitals":
        return Icons.monitor_heart;
      case "care":
        return Icons.support;
      case "therapy":
        return Icons.fitness_center;
      default:
        return Icons.task;
    }
  }

  void _showNotificationsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Notifications"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: notifications.map((notification) {
              Color notificationColor = notification["priority"] == "high" 
                  ? dangerColor 
                  : warningColor;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: notificationColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: notificationColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${notification["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: notificationColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${notification["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${notification["message"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emergency, color: dangerColor),
            SizedBox(width: spSm),
            Text("Emergency Actions"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QButton(
              label: "Call 911",
              color: dangerColor,
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                ss("Emergency services contacted");
              },
            ),
            QButton(
              label: "Call Supervisor",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                ss("Supervisor contacted");
              },
            ),
            QButton(
              label: "Report Incident",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                _showIncidentReportDialog();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showPatientDetailsDialog(Map<String, dynamic> patient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${patient["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Age: ${patient["age"]}"),
            Text("Address: ${patient["address"]}"),
            Text("Schedule: ${patient["time"]}"),
            Text("Conditions: ${(patient["conditions"] as List).join(", ")}"),
            Text("Tasks: ${patient["completed"]}/${patient["tasks"]} completed"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showAddNoteDialog(String patientName) {
    String note = "";
    String noteType = "general";
    
    List<Map<String, dynamic>> noteTypes = [
      {"label": "General", "value": "general"},
      {"label": "Medication", "value": "medication"},
      {"label": "Vitals", "value": "vitals"},
      {"label": "Therapy", "value": "therapy"},
      {"label": "Care", "value": "care"},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Note - $patientName"),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Note Type",
                items: noteTypes,
                value: noteType,
                onChanged: (value, label) {
                  noteType = value;
                  setDialogState(() {});
                },
              ),
              QMemoField(
                label: "Note",
                value: note,
                onChanged: (value) {
                  note = value;
                  setDialogState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Note",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Note added successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showIncidentReportDialog() {
    String incidentType = "medical";
    String description = "";
    String patientInvolved = "";
    
    List<Map<String, dynamic>> incidentTypes = [
      {"label": "Medical Emergency", "value": "medical"},
      {"label": "Fall", "value": "fall"},
      {"label": "Medication Error", "value": "medication"},
      {"label": "Equipment Failure", "value": "equipment"},
      {"label": "Other", "value": "other"},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Report Incident"),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Patient Involved",
                value: patientInvolved,
                onChanged: (value) {
                  patientInvolved = value;
                  setDialogState(() {});
                },
              ),
              QDropdownField(
                label: "Incident Type",
                items: incidentTypes,
                value: incidentType,
                onChanged: (value, label) {
                  incidentType = value;
                  setDialogState(() {});
                },
              ),
              QMemoField(
                label: "Description",
                value: description,
                onChanged: (value) {
                  description = value;
                  setDialogState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Submit Report",
            color: dangerColor,
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Incident report submitted");
            },
          ),
        ],
      ),
    );
  }
}

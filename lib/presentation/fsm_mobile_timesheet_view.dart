import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmMobileTimesheetView extends StatefulWidget {
  const FsmMobileTimesheetView({super.key});

  @override
  State<FsmMobileTimesheetView> createState() => _FsmMobileTimesheetViewState();
}

class _FsmMobileTimesheetViewState extends State<FsmMobileTimesheetView> {
  String selectedWeek = "2024-12-16";
  String selectedProject = "";
  String selectedActivity = "";
  
  bool isTimerRunning = false;
  String currentActivity = "";
  String currentProject = "";
  DateTime? timerStartTime;
  String elapsedTime = "00:00:00";
  
  List<Map<String, dynamic>> timesheetEntries = [
    {
      "id": "TS-001",
      "date": "2024-12-16",
      "project": "Metro Office Complex",
      "workOrder": "WO-2024-001",
      "activity": "HVAC Maintenance",
      "startTime": "08:15:00",
      "endTime": "12:00:00",
      "duration": "3:45:00",
      "hours": 3.75,
      "status": "Approved",
      "notes": "Completed system inspection and filter replacement",
      "location": "Downtown Service Center",
      "billable": true,
    },
    {
      "id": "TS-002",
      "date": "2024-12-16",
      "project": "Metro Office Complex",
      "workOrder": "WO-2024-001",
      "activity": "Documentation",
      "startTime": "13:00:00",
      "endTime": "14:30:00",
      "duration": "1:30:00",
      "hours": 1.5,
      "status": "Pending",
      "notes": "Updated maintenance records and customer report",
      "location": "Downtown Service Center",
      "billable": true,
    },
    {
      "id": "TS-003",
      "date": "2024-12-17",
      "project": "Riverside Apartments",
      "workOrder": "WO-2024-002",
      "activity": "Emergency Repair",
      "startTime": "09:00:00",
      "endTime": "11:45:00",
      "duration": "2:45:00",
      "hours": 2.75,
      "status": "Approved",
      "notes": "Fixed burst pipe and restored water pressure",
      "location": "Riverside District",
      "billable": true,
    },
    {
      "id": "TS-004",
      "date": "2024-12-17",
      "project": "Administrative",
      "workOrder": "",
      "activity": "Training",
      "startTime": "14:00:00",
      "endTime": "16:00:00",
      "duration": "2:00:00",
      "hours": 2.0,
      "status": "Approved",
      "notes": "Safety training and equipment certification",
      "location": "Main Office",
      "billable": false,
    },
    {
      "id": "TS-005",
      "date": "2024-12-18",
      "project": "Creative Design Studio",
      "workOrder": "WO-2024-003",
      "activity": "Electrical Installation",
      "startTime": "08:30:00",
      "endTime": "12:30:00",
      "duration": "4:00:00",
      "hours": 4.0,
      "status": "Draft",
      "notes": "Installing new outlets and electrical connections",
      "location": "Creative District",
      "billable": true,
    },
  ];

  List<Map<String, dynamic>> projects = [
    {"label": "Metro Office Complex", "value": "Metro Office Complex"},
    {"label": "Riverside Apartments", "value": "Riverside Apartments"},
    {"label": "Creative Design Studio", "value": "Creative Design Studio"},
    {"label": "Administrative", "value": "Administrative"},
    {"label": "Training", "value": "Training"},
  ];

  List<Map<String, dynamic>> activities = [
    {"label": "HVAC Maintenance", "value": "HVAC Maintenance"},
    {"label": "Plumbing Repair", "value": "Plumbing Repair"},
    {"label": "Electrical Installation", "value": "Electrical Installation"},
    {"label": "Emergency Repair", "value": "Emergency Repair"},
    {"label": "Documentation", "value": "Documentation"},
    {"label": "Training", "value": "Training"},
    {"label": "Travel Time", "value": "Travel Time"},
    {"label": "Administrative Work", "value": "Administrative Work"},
  ];

  List<Map<String, dynamic>> get weekEntries {
    return timesheetEntries.where((entry) {
      DateTime entryDate = DateTime.parse("${entry["date"]}");
      DateTime weekStart = DateTime.parse(selectedWeek);
      DateTime weekEnd = weekStart.add(Duration(days: 6));
      return entryDate.isAfter(weekStart.subtract(Duration(days: 1))) && 
             entryDate.isBefore(weekEnd.add(Duration(days: 1)));
    }).toList();
  }

  double get totalHours {
    return weekEntries.fold(0.0, (sum, entry) => sum + (entry["hours"] as num).toDouble());
  }

  double get billableHours {
    return weekEntries
        .where((entry) => entry["billable"] == true)
        .fold(0.0, (sum, entry) => sum + (entry["hours"] as num).toDouble());
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Draft":
        return warningColor;
      case "Pending":
        return infoColor;
      case "Approved":
        return successColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void startTimer() {
    if (currentProject.isEmpty || currentActivity.isEmpty) {
      se("Please select project and activity before starting timer");
      return;
    }
    
    setState(() {
      isTimerRunning = true;
      timerStartTime = DateTime.now();
    });
    
    ss("Timer started for $currentActivity");
  }

  void stopTimer() async {
    if (!isTimerRunning || timerStartTime == null) return;
    
    bool isConfirmed = await confirm("Stop timer and save timesheet entry?");
    if (!isConfirmed) return;
    
    setState(() {
      isTimerRunning = false;
      timerStartTime = null;
      elapsedTime = "00:00:00";
    });
    
    ss("Timesheet entry saved successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Timesheet"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_alarm),
            onPressed: () {
              // navigateTo('AddTimesheetEntryView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Timer Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isTimerRunning ? successColor.withAlpha(20) : primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isTimerRunning ? successColor : primaryColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    isTimerRunning ? Icons.timer : Icons.access_time,
                    size: 48,
                    color: isTimerRunning ? successColor : primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    isTimerRunning ? "TIMER RUNNING" : "TIMER STOPPED",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: isTimerRunning ? successColor : primaryColor,
                    ),
                  ),
                  Text(
                    elapsedTime,
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: isTimerRunning ? successColor : primaryColor,
                      fontFamily: 'monospace',
                    ),
                  ),
                  if (isTimerRunning && currentActivity.isNotEmpty)
                    Text(
                      "Activity: $currentActivity",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                ],
              ),
            ),

            // Timer Controls
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.play_circle, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Time Tracker",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Project",
                    items: projects,
                    value: currentProject,
                    onChanged: (value, label) {
                      currentProject = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Activity",
                    items: activities,
                    value: currentActivity,
                    onChanged: (value, label) {
                      currentActivity = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: isTimerRunning ? "Stop Timer" : "Start Timer",
                          color: isTimerRunning ? dangerColor : successColor,
                          onPressed: isTimerRunning ? stopTimer : startTimer,
                        ),
                      ),
                      if (isTimerRunning) ...[
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.pause,
                          size: bs.sm,
                          color: warningColor,
                          onPressed: () {
                            ss("Timer paused");
                          },
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Week Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_view_week, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Week Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        icon: Icons.chevron_left,
                        size: bs.sm,
                        onPressed: () {
                          DateTime current = DateTime.parse(selectedWeek);
                          DateTime previous = current.subtract(Duration(days: 7));
                          selectedWeek = "${previous.year}-${previous.month.toString().padLeft(2, '0')}-${previous.day.toString().padLeft(2, '0')}";
                          setState(() {});
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.chevron_right,
                        size: bs.sm,
                        onPressed: () {
                          DateTime current = DateTime.parse(selectedWeek);
                          DateTime next = current.add(Duration(days: 7));
                          selectedWeek = "${next.year}-${next.month.toString().padLeft(2, '0')}-${next.day.toString().padLeft(2, '0')}";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Text(
                    "Week of ${DateTime.parse(selectedWeek).dMMMy}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${totalHours.toStringAsFixed(1)}h",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Hours",
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
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${billableHours.toStringAsFixed(1)}h",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Billable",
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${weekEntries.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Entries",
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
                ],
              ),
            ),

            // Timesheet Entries
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Timesheet Entries (${weekEntries.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...weekEntries.map((entry) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getStatusColor("${entry["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${entry["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (entry["billable"] as bool) ? successColor : disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  (entry["billable"] as bool) ? "Billable" : "Non-Billable",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${DateTime.parse("${entry["date"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${(entry["hours"] as num).toStringAsFixed(2)}h",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${entry["project"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${entry["activity"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "${entry["startTime"]} - ${entry["endTime"]} (${entry["duration"]})",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if ("${entry["workOrder"]}".isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.work, size: 14, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text(
                                  "Work Order: ${entry["workOrder"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          if ("${entry["notes"]}".isNotEmpty)
                            Text(
                              "${entry["notes"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                color: disabledBoldColor,
                              ),
                            ),
                          Row(
                            children: [
                              QButton(
                                label: "Edit",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo('EditTimesheetEntryView')
                                },
                              ),
                              SizedBox(width: spSm),
                              if ("${entry["status"]}" == "Draft")
                                QButton(
                                  label: "Submit",
                                  size: bs.sm,
                                  color: successColor,
                                  onPressed: () async {
                                    bool isConfirmed = await confirm("Submit this timesheet entry?");
                                    if (isConfirmed) {
                                      ss("Timesheet entry submitted successfully");
                                    }
                                  },
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
          ],
        ),
      ),
    );
  }
}

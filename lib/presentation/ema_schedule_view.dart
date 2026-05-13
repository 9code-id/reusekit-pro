import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaScheduleView extends StatefulWidget {
  const EmaScheduleView({super.key});

  @override
  State<EmaScheduleView> createState() => _EmaScheduleViewState();
}

class _EmaScheduleViewState extends State<EmaScheduleView> {
  DateTime selectedDate = DateTime.now();
  String selectedView = "Day";
  List<String> viewOptions = ["Day", "Week", "Month"];

  List<Map<String, dynamic>> scheduleItems = [
    {
      "id": 1,
      "title": "Morning Assessment",
      "time": "08:00",
      "duration": 10,
      "type": "assessment",
      "status": "completed",
      "date": "2025-06-18",
      "description": "Daily mood and energy check-in",
      "streak": 7,
    },
    {
      "id": 2,
      "title": "Mid-Morning Stress Check",
      "time": "10:30",
      "duration": 5,
      "type": "quickcheck",
      "status": "pending",
      "date": "2025-06-18",
      "description": "Quick stress level assessment",
      "streak": 3,
    },
    {
      "id": 3,
      "title": "Lunch Break Reflection",
      "time": "12:30",
      "duration": 8,
      "type": "assessment",
      "status": "pending",
      "date": "2025-06-18",
      "description": "Productivity and wellbeing check",
      "streak": 5,
    },
    {
      "id": 4,
      "title": "Afternoon Energy Boost",
      "time": "15:00",
      "duration": 3,
      "type": "reminder",
      "status": "scheduled",
      "date": "2025-06-18",
      "description": "Mindfulness and energy assessment",
      "streak": 0,
    },
    {
      "id": 5,
      "title": "Evening Wind Down",
      "time": "20:00",
      "duration": 12,
      "type": "assessment",
      "status": "scheduled",
      "date": "2025-06-18",
      "description": "Daily reflection and tomorrow preparation",
      "streak": 4,
    },
    {
      "id": 6,
      "title": "Sleep Quality Review",
      "time": "22:30",
      "duration": 5,
      "type": "quickcheck",
      "status": "scheduled",
      "date": "2025-06-18",
      "description": "Sleep preparation assessment",
      "streak": 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> todayItems = scheduleItems
        .where((item) => item["date"] == selectedDate.toString().split(' ')[0])
        .toList();

    int completedToday = todayItems.where((item) => item["status"] == "completed").length;
    int totalToday = todayItems.length;
    double completionRate = totalToday > 0 ? (completedToday / totalToday) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("EMA Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // navigateTo('CalendarView')
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('AddScheduleView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Date Selector
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Today's Schedule",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.date_range,
                        size: bs.sm,
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now().subtract(Duration(days: 30)),
                            lastDate: DateTime.now().add(Duration(days: 30)),
                          );
                          if (picked != null) {
                            selectedDate = picked;
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${completedToday}/${totalToday}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Completed",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${(completionRate * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Progress",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${todayItems.map((item) => item["duration"] as int).fold(0, (sum, duration) => sum + duration)} min",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Total Time",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
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

            // View Options
            QCategoryPicker(
              items: viewOptions.map((view) => {
                "label": view,
                "value": view,
              }).toList(),
              value: selectedView,
              onChanged: (index, label, value, item) {
                selectedView = value;
                setState(() {});
              },
            ),

            // Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Daily Progress",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(completionRate * 100).toInt()}% Complete",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: completionRate,
                    child: Container(
                      decoration: BoxDecoration(
                        color: completionRate >= 0.8 ? successColor : 
                               completionRate >= 0.5 ? warningColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Schedule Items
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Today's Assessments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: todayItems.map((item) {
                    Color statusColor = _getStatusColor(item["status"]);
                    Color typeColor = _getTypeColor(item["type"]);
                    IconData statusIcon = _getStatusIcon(item["status"]);
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
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
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: typeColor.withAlpha(15),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getTypeIcon(item["type"]),
                                  size: 20,
                                  color: typeColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${item["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${item["description"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(15),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      statusIcon,
                                      size: 14,
                                      color: statusColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${item["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${item["time"]} • ${item["duration"]} minutes",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if ((item["streak"] as int) > 0) ...[
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(15),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.local_fire_department,
                                        size: 12,
                                        color: successColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${item["streak"]} streak",
                                        style: TextStyle(
                                          color: successColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),

                          if (item["status"] != "completed")
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: item["status"] == "pending" 
                                    ? "Start Assessment" 
                                    : "Scheduled",
                                size: bs.sm,
                                onPressed: item["status"] == "pending" 
                                    ? () {
                                        // navigateTo('AssessmentView')
                                      } 
                                    : null,
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            if (todayItems.isEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_available,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No assessments scheduled",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Add new assessments to your schedule",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Add Assessment",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('AddScheduleView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "View Calendar",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('CalendarView')
                          },
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "pending":
        return warningColor;
      case "scheduled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "assessment":
        return primaryColor;
      case "quickcheck":
        return infoColor;
      case "reminder":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "pending":
        return Icons.pending;
      case "scheduled":
        return Icons.schedule;
      default:
        return Icons.help;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "assessment":
        return Icons.assignment;
      case "quickcheck":
        return Icons.quiz;
      case "reminder":
        return Icons.notifications;
      default:
        return Icons.event;
    }
  }
}

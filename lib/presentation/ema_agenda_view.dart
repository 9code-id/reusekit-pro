import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaAgendaView extends StatefulWidget {
  const EmaAgendaView({super.key});

  @override
  State<EmaAgendaView> createState() => _EmaAgendaViewState();
}

class _EmaAgendaViewState extends State<EmaAgendaView> {
  DateTime selectedDate = DateTime.now();
  String selectedView = "Today";
  List<String> viewOptions = ["Today", "This Week", "This Month"];

  List<Map<String, dynamic>> agendaItems = [
    {
      "id": 1,
      "title": "Morning Wellness Check",
      "date": "2025-06-18",
      "time": "08:00",
      "type": "assessment",
      "priority": "high",
      "status": "completed",
      "duration": 10,
      "category": "wellbeing",
      "location": "Home",
      "reminder": true,
      "notes": "Focus on energy levels and mood",
    },
    {
      "id": 2,
      "title": "Team Meeting EMA",
      "date": "2025-06-18",
      "time": "10:00",
      "type": "social",
      "priority": "medium",
      "status": "upcoming",
      "duration": 15,
      "category": "workplace",
      "location": "Office",
      "reminder": true,
      "notes": "Post-meeting stress and collaboration assessment",
    },
    {
      "id": 3,
      "title": "Lunch Break Reflection",
      "date": "2025-06-18",
      "time": "12:30",
      "type": "reflection",
      "priority": "low",
      "status": "upcoming",
      "duration": 8,
      "category": "nutrition",
      "location": "Cafeteria",
      "reminder": false,
      "notes": "Meal satisfaction and energy check",
    },
    {
      "id": 4,
      "title": "Exercise Recovery Assessment",
      "date": "2025-06-18",
      "time": "18:30",
      "type": "physical",
      "priority": "high",
      "status": "upcoming",
      "duration": 12,
      "category": "fitness",
      "location": "Gym",
      "reminder": true,
      "notes": "Post-workout mood and physical state",
    },
    {
      "id": 5,
      "title": "Evening Wind Down",
      "date": "2025-06-18",
      "time": "21:00",
      "type": "reflection",
      "priority": "medium",
      "status": "upcoming",
      "duration": 15,
      "category": "relaxation",
      "location": "Home",
      "reminder": true,
      "notes": "Daily reflection and sleep preparation",
    },
    {
      "id": 6,
      "title": "Weekly Review Session",
      "date": "2025-06-19",
      "time": "09:00",
      "type": "review",
      "priority": "high",
      "status": "scheduled",
      "duration": 30,
      "category": "progress",
      "location": "Home",
      "reminder": true,
      "notes": "Comprehensive weekly progress evaluation",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredItems = _getFilteredItems();
    int completedToday = filteredItems.where((item) => item["status"] == "completed").length;
    int upcomingToday = filteredItems.where((item) => item["status"] == "upcoming").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("EMA Agenda"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // navigateTo('SearchAgendaView')
            },
          ),
          IconButton(
            icon: Icon(Icons.add_task),
            onPressed: () {
              // navigateTo('AddAgendaItemView')
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
            // Header Summary
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
                        Icons.event_note,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "EMA Agenda",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.calendar_today,
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
                              "${completedToday}",
                              style: TextStyle(
                                fontSize: fsH3,
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
                              "${upcomingToday}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Upcoming",
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
                              "${filteredItems.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Items",
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

            // Agenda Timeline
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Agenda Timeline",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...filteredItems.map((item) {
                  Color statusColor = _getStatusColor(item["status"]);
                  Color priorityColor = _getPriorityColor(item["priority"]);
                  Color categoryColor = _getCategoryColor(item["category"]);
                  IconData typeIcon = _getTypeIcon(item["type"]);

                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
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
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(radiusMd),
                        onTap: () {
                          // navigateTo('AgendaDetailView')
                        },
                        child: Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: categoryColor.withAlpha(15),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      typeIcon,
                                      size: 20,
                                      color: categoryColor,
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
                                          "${item["notes"]}",
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
                                      color: priorityColor.withAlpha(15),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${item["priority"]}".toUpperCase(),
                                      style: TextStyle(
                                        color: priorityColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                                    "${item["time"]} • ${item["duration"]} min",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${item["location"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (item["reminder"])
                                    Padding(
                                      padding: EdgeInsets.only(left: spSm),
                                      child: Icon(
                                        Icons.notifications_active,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                    ),
                                ],
                              ),

                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: categoryColor.withAlpha(15),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${item["category"]}".toUpperCase(),
                                      style: TextStyle(
                                        color: categoryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
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
                                          _getStatusIcon(item["status"]),
                                          size: 12,
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

                              if (item["status"] == "upcoming")
                                Container(
                                  width: double.infinity,
                                  child: QButton(
                                    label: "Start Assessment",
                                    size: bs.sm,
                                    onPressed: () {
                                      // navigateTo('AssessmentView')
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),

            if (filteredItems.isEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No agenda items found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Add new items to your agenda",
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
                          label: "Add Item",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('AddAgendaItemView')
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

  List<Map<String, dynamic>> _getFilteredItems() {
    DateTime today = DateTime.now();
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
    DateTime startOfMonth = DateTime(today.year, today.month, 1);
    DateTime endOfMonth = DateTime(today.year, today.month + 1, 0);

    return agendaItems.where((item) {
      DateTime itemDate = DateTime.parse(item["date"]);
      
      switch (selectedView) {
        case "Today":
          return itemDate.day == selectedDate.day &&
                 itemDate.month == selectedDate.month &&
                 itemDate.year == selectedDate.year;
        case "This Week":
          return itemDate.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
                 itemDate.isBefore(endOfWeek.add(Duration(days: 1)));
        case "This Month":
          return itemDate.isAfter(startOfMonth.subtract(Duration(days: 1))) &&
                 itemDate.isBefore(endOfMonth.add(Duration(days: 1)));
        default:
          return true;
      }
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "upcoming":
        return warningColor;
      case "scheduled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case "wellbeing":
        return primaryColor;
      case "workplace":
        return infoColor;
      case "nutrition":
        return successColor;
      case "fitness":
        return warningColor;
      case "relaxation":
        return secondaryColor;
      case "progress":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "assessment":
        return Icons.assignment;
      case "social":
        return Icons.people;
      case "reflection":
        return Icons.self_improvement;
      case "physical":
        return Icons.fitness_center;
      case "review":
        return Icons.analytics;
      default:
        return Icons.event;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "upcoming":
        return Icons.pending;
      case "scheduled":
        return Icons.schedule;
      default:
        return Icons.help;
    }
  }
}

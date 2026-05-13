import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaReminderView extends StatefulWidget {
  const EmaReminderView({super.key});

  @override
  State<EmaReminderView> createState() => _EmaReminderViewState();
}

class _EmaReminderViewState extends State<EmaReminderView> {
  List<Map<String, dynamic>> reminders = [
    {
      "id": 1,
      "title": "Morning Assessment",
      "time": "08:00",
      "frequency": "Daily",
      "isActive": true,
      "description": "Complete your morning mood and energy assessment",
      "lastCompleted": "2025-06-17",
      "streak": 7,
    },
    {
      "id": 2,
      "title": "Lunch Check-in",
      "time": "12:30",
      "frequency": "Daily",
      "isActive": true,
      "description": "Rate your stress level and productivity",
      "lastCompleted": "2025-06-17",
      "streak": 5,
    },
    {
      "id": 3,
      "title": "Evening Reflection",
      "time": "20:00",
      "frequency": "Daily",
      "isActive": false,
      "description": "Reflect on your day and set tomorrow's intentions",
      "lastCompleted": "2025-06-15",
      "streak": 3,
    },
    {
      "id": 4,
      "title": "Weekly Review",
      "time": "19:00",
      "frequency": "Weekly",
      "isActive": true,
      "description": "Comprehensive weekly assessment and goal setting",
      "lastCompleted": "2025-06-14",
      "streak": 2,
    },
    {
      "id": 5,
      "title": "Exercise Tracker",
      "time": "06:30",
      "frequency": "Daily",
      "isActive": true,
      "description": "Log your physical activity and energy levels",
      "lastCompleted": "2025-06-17",
      "streak": 12,
    },
  ];

  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Active", "Inactive"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredReminders = reminders.where((reminder) {
      if (selectedFilter == "Active") return reminder["isActive"] == true;
      if (selectedFilter == "Inactive") return reminder["isActive"] == false;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("EMA Reminders"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('CreateReminderView')
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
            // Summary Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${reminders.where((r) => r["isActive"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Active Reminders",
                          textAlign: TextAlign.center,
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
                          "${reminders.map((r) => r["streak"] as int).reduce((a, b) => a + b)}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Streaks",
                          textAlign: TextAlign.center,
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
                          "${((reminders.where((r) => r["lastCompleted"] == "2025-06-17").length / reminders.length) * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Completion Rate",
                          textAlign: TextAlign.center,
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
            ),

            // Filter Options
            QCategoryPicker(
              items: filterOptions.map((filter) => {
                "label": filter,
                "value": filter,
              }).toList(),
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Section Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Your Reminders",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Text(
                  "${filteredReminders.length} reminder${filteredReminders.length != 1 ? 's' : ''}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            // Reminders List
            Column(
              spacing: spSm,
              children: filteredReminders.map((reminder) {
                Color statusColor = reminder["isActive"] ? primaryColor : disabledBoldColor;
                Color streakColor = (reminder["streak"] as int) >= 7 ? successColor : 
                                  (reminder["streak"] as int) >= 3 ? warningColor : dangerColor;

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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${reminder["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${reminder["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo('EditReminderView')
                            },
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: statusColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${reminder["time"]} • ${reminder["frequency"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: streakColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  size: 14,
                                  color: streakColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${reminder["streak"]} day streak",
                                  style: TextStyle(
                                    color: streakColor,
                                    fontSize: 12,
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
                            Icons.check_circle,
                            size: 16,
                            color: reminder["lastCompleted"] == "2025-06-17" 
                                ? successColor 
                                : disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Last completed: ${reminder["lastCompleted"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: reminder["isActive"]
                                  ? successColor.withAlpha(15)
                                  : disabledColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              reminder["isActive"] ? "Active" : "Inactive",
                              style: TextStyle(
                                color: reminder["isActive"] ? successColor : disabledBoldColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: reminder["lastCompleted"] == "2025-06-17" 
                              ? "Completed Today" 
                              : "Take Assessment",
                          size: bs.sm,
                          onPressed: reminder["lastCompleted"] == "2025-06-17" 
                              ? null 
                              : () {
                                  // navigateTo('AssessmentView')
                                },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
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
                          label: "Add Reminder",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('CreateReminderView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Settings",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('ReminderSettingsView')
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
}

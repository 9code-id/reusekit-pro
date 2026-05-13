import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaBedtimeReminderView extends StatefulWidget {
  const FwaBedtimeReminderView({super.key});

  @override
  State<FwaBedtimeReminderView> createState() => _FwaBedtimeReminderViewState();
}

class _FwaBedtimeReminderViewState extends State<FwaBedtimeReminderView> {
  bool bedtimeRemindersEnabled = true;
  bool windDownRemindersEnabled = true;
  bool smartRemindersEnabled = true;
  bool weekendRemindersEnabled = false;
  TimeOfDay bedtime = TimeOfDay(hour: 22, minute: 30);
  TimeOfDay wakeTime = TimeOfDay(hour: 6, minute: 30);
  int windDownDuration = 60;
  String reminderTone = "Gentle Chimes";
  String reminderFrequency = "30 minutes before";

  List<Map<String, dynamic>> reminderTones = [
    {"label": "Gentle Chimes", "value": "Gentle Chimes"},
    {"label": "Forest Sounds", "value": "Forest Sounds"},
    {"label": "Ocean Waves", "value": "Ocean Waves"},
    {"label": "Rain Drops", "value": "Rain Drops"},
    {"label": "Silent (Vibration)", "value": "Silent"},
  ];

  List<Map<String, dynamic>> reminderFrequencies = [
    {"label": "15 minutes before", "value": "15 minutes before"},
    {"label": "30 minutes before", "value": "30 minutes before"},
    {"label": "45 minutes before", "value": "45 minutes before"},
    {"label": "1 hour before", "value": "1 hour before"},
    {"label": "90 minutes before", "value": "90 minutes before"},
  ];

  List<Map<String, dynamic>> bedtimeReminders = [
    {
      "id": 1,
      "type": "bedtime",
      "title": "Bedtime Reminder",
      "time": TimeOfDay(hour: 22, minute: 0),
      "message": "Time to start winding down for bed",
      "enabled": true,
      "days": ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
      "tone": "Gentle Chimes",
      "vibration": true,
    },
    {
      "id": 2,
      "type": "wind_down",
      "title": "Wind Down Reminder",
      "time": TimeOfDay(hour: 21, minute: 30),
      "message": "Start your bedtime routine",
      "enabled": true,
      "days": ["Mon", "Tue", "Wed", "Thu", "Fri"],
      "tone": "Forest Sounds",
      "vibration": false,
    },
    {
      "id": 3,
      "type": "screen_time",
      "title": "No Screen Time",
      "time": TimeOfDay(hour: 21, minute: 0),
      "message": "Put away devices for better sleep",
      "enabled": true,
      "days": ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
      "tone": "Silent",
      "vibration": true,
    },
    {
      "id": 4,
      "type": "environment",
      "title": "Sleep Environment",
      "time": TimeOfDay(hour: 21, minute: 45),
      "message": "Dim lights and prepare bedroom",
      "enabled": false,
      "days": ["Mon", "Tue", "Wed", "Thu", "Fri"],
      "tone": "Ocean Waves",
      "vibration": false,
    },
  ];

  List<Map<String, dynamic>> windDownActivities = [
    {
      "name": "Reading",
      "duration": "20-30 minutes",
      "description": "Read a physical book or e-reader with warm light",
      "icon": Icons.menu_book,
      "enabled": true,
    },
    {
      "name": "Meditation",
      "duration": "10-15 minutes",
      "description": "Practice mindfulness or guided meditation",
      "icon": Icons.self_improvement,
      "enabled": true,
    },
    {
      "name": "Gentle Stretching",
      "duration": "10-15 minutes",
      "description": "Light yoga or stretching exercises",
      "icon": Icons.accessibility_new,
      "enabled": false,
    },
    {
      "name": "Journaling",
      "duration": "10-15 minutes",
      "description": "Write down thoughts or gratitude entries",
      "icon": Icons.edit_note,
      "enabled": true,
    },
    {
      "name": "Herbal Tea",
      "duration": "5-10 minutes",
      "description": "Chamomile or other caffeine-free tea",
      "icon": Icons.local_cafe,
      "enabled": false,
    },
    {
      "name": "Deep Breathing",
      "duration": "5-10 minutes",
      "description": "4-7-8 breathing or other relaxation techniques",
      "icon": Icons.air,
      "enabled": true,
    },
  ];

  List<Map<String, dynamic>> recentReminders = [
    {
      "date": DateTime.now().subtract(Duration(hours: 2)),
      "type": "bedtime",
      "title": "Bedtime Reminder",
      "acknowledged": true,
      "actualBedtime": DateTime.now().subtract(Duration(hours: 1, minutes: 45)),
    },
    {
      "date": DateTime.now().subtract(Duration(days: 1, hours: 2)),
      "type": "wind_down",
      "title": "Wind Down Reminder",
      "acknowledged": true,
      "actualBedtime": DateTime.now().subtract(Duration(days: 1, hours: 1, minutes: 30)),
    },
    {
      "date": DateTime.now().subtract(Duration(days: 2, hours: 2)),
      "type": "bedtime",
      "title": "Bedtime Reminder",
      "acknowledged": false,
      "actualBedtime": DateTime.now().subtract(Duration(days: 2, hours: 1, minutes: 15)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bedtime Reminders"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.history),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Quick Settings
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
                      Icon(Icons.settings, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Reminder Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Bedtime Reminders",
                        "value": true,
                        "checked": bedtimeRemindersEnabled,
                      }
                    ],
                    value: [if (bedtimeRemindersEnabled) {"label": "Enable Bedtime Reminders", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      bedtimeRemindersEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Smart Reminders (Adaptive)",
                        "value": true,
                        "checked": smartRemindersEnabled,
                      }
                    ],
                    value: [if (smartRemindersEnabled) {"label": "Smart Reminders (Adaptive)", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      smartRemindersEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Weekend Reminders",
                        "value": true,
                        "checked": weekendRemindersEnabled,
                      }
                    ],
                    value: [if (weekendRemindersEnabled) {"label": "Weekend Reminders", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      weekendRemindersEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Sleep Schedule
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
                      Icon(Icons.schedule, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Sleep Schedule",
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
                        child: QTimePicker(
                          label: "Bedtime",
                          value: bedtime,
                          onChanged: (value) {
                            if (value != null) {
                              bedtime = value;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTimePicker(
                          label: "Wake Time",
                          value: wakeTime,
                          onChanged: (value) {
                            if (value != null) {
                              wakeTime = value;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.bedtime, color: primaryColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Sleep Duration: ${_calculateSleepDuration()}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Wind Down Settings
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
                      Icon(Icons.nightlight, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Wind Down Routine",
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
                      Text(
                        "Wind Down Duration: $windDownDuration minutes",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: windDownDuration.toDouble(),
                    min: 30.0,
                    max: 120.0,
                    divisions: 18,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      windDownDuration = value.toInt();
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Reminder Frequency",
                          items: reminderFrequencies,
                          value: reminderFrequency,
                          onChanged: (value, label) {
                            reminderFrequency = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Reminder Tone",
                          items: reminderTones,
                          value: reminderTone,
                          onChanged: (value, label) {
                            reminderTone = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Active Reminders
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
                      Icon(Icons.notifications_active, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Active Reminders",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${bedtimeReminders.where((r) => r["enabled"]).length} active",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  ...bedtimeReminders.map((reminder) {
                    bool enabled = reminder["enabled"];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: enabled ? Colors.white : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: enabled ? primaryColor.withAlpha(30) : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getReminderIcon(reminder["type"]),
                                color: enabled ? primaryColor : disabledBoldColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${reminder["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: enabled ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(reminder["time"] as TimeOfDay).kkmm}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                icon: enabled ? Icons.pause : Icons.play_arrow,
                                size: bs.sm,
                                onPressed: () {
                                  reminder["enabled"] = !enabled;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          Text(
                            "${reminder["message"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Days: ${(reminder["days"] as List).join(", ")}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${reminder["tone"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (reminder["vibration"])
                                Padding(
                                  padding: EdgeInsets.only(left: spXs),
                                  child: Icon(Icons.vibration, size: 12, color: disabledBoldColor),
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

            // Wind Down Activities
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
                      Icon(Icons.spa, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Suggested Wind Down Activities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Activities to help you relax before bedtime",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: windDownActivities.map((activity) {
                      bool enabled = activity["enabled"];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: enabled ? primaryColor.withAlpha(10) : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: enabled ? primaryColor.withAlpha(30) : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: enabled ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    activity["icon"],
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${activity["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: enabled ? primaryColor : disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${activity["duration"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    activity["enabled"] = !enabled;
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: enabled ? primaryColor : Colors.transparent,
                                      border: Border.all(
                                        color: enabled ? primaryColor : disabledBoldColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: enabled
                                        ? Icon(Icons.check, size: 12, color: Colors.white)
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${activity["description"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
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

            // Recent Reminder History
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
                      Icon(Icons.history, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Recent Reminders",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...recentReminders.map((reminder) {
                    bool acknowledged = reminder["acknowledged"];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: acknowledged ? Colors.grey[50] : warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: acknowledged ? disabledOutlineBorderColor : warningColor.withAlpha(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            acknowledged ? Icons.check_circle : Icons.warning,
                            color: acknowledged ? successColor : warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${reminder["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(reminder["date"] as DateTime).dMMMy} at ${(reminder["date"] as DateTime).kkmm}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (reminder["actualBedtime"] != null)
                                  Text(
                                    "Actual bedtime: ${(reminder["actualBedtime"] as DateTime).kkmm}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: acknowledged ? successColor : dangerColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            acknowledged ? "Followed" : "Missed",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: acknowledged ? successColor : dangerColor,
                            ),
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

  String _calculateSleepDuration() {
    int bedtimeMinutes = bedtime.hour * 60 + bedtime.minute;
    int wakeTimeMinutes = wakeTime.hour * 60 + wakeTime.minute;
    
    int sleepMinutes;
    if (wakeTimeMinutes > bedtimeMinutes) {
      sleepMinutes = wakeTimeMinutes - bedtimeMinutes;
    } else {
      sleepMinutes = (24 * 60) - bedtimeMinutes + wakeTimeMinutes;
    }
    
    int hours = sleepMinutes ~/ 60;
    int minutes = sleepMinutes % 60;
    
    return "${hours}h ${minutes}m";
  }

  IconData _getReminderIcon(String type) {
    switch (type) {
      case "bedtime":
        return Icons.bedtime;
      case "wind_down":
        return Icons.nightlight;
      case "screen_time":
        return Icons.phone_android;
      case "environment":
        return Icons.home;
      default:
        return Icons.notifications;
    }
  }
}

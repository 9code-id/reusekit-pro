import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMeditation10View extends StatefulWidget {
  @override
  State<GrlMeditation10View> createState() => _GrlMeditation10ViewState();
}

class _GrlMeditation10ViewState extends State<GrlMeditation10View> {
  String meditationGoal = "better_sleep";
  int dailyMinutes = 10;
  String preferredTime = "morning";
  bool remindersEnabled = true;
  String reminderTime = "07:00";
  bool weekendReminders = false;

  List<Map<String, dynamic>> goalOptions = [
    {
      "label": "Better Sleep",
      "value": "better_sleep",
      "icon": Icons.bedtime,
      "color": primaryColor,
      "description": "Improve sleep quality and duration",
    },
    {
      "label": "Reduce Stress",
      "value": "reduce_stress",
      "icon": Icons.spa,
      "color": successColor,
      "description": "Manage stress and anxiety levels",
    },
    {
      "label": "Increase Focus",
      "value": "increase_focus",
      "icon": Icons.center_focus_strong,
      "color": infoColor,
      "description": "Enhance concentration and mental clarity",
    },
    {
      "label": "Emotional Balance",
      "value": "emotional_balance",
      "icon": Icons.favorite,
      "color": warningColor,
      "description": "Achieve emotional stability and peace",
    },
    {
      "label": "Physical Healing",
      "value": "physical_healing",
      "icon": Icons.healing,
      "color": successColor,
      "description": "Support physical recovery and wellness",
    },
    {
      "label": "Spiritual Growth",
      "value": "spiritual_growth",
      "icon": Icons.self_improvement,
      "color": primaryColor,
      "description": "Deepen spiritual awareness and connection",
    },
  ];

  List<Map<String, dynamic>> timeOptions = [
    {
      "label": "Morning (6-9 AM)",
      "value": "morning",
      "icon": Icons.wb_sunny,
      "description": "Start your day with mindfulness",
    },
    {
      "label": "Lunch Break (12-2 PM)",
      "value": "lunch",
      "icon": Icons.lunch_dining,
      "description": "Reset during midday",
    },
    {
      "label": "Evening (6-8 PM)",
      "value": "evening",
      "icon": Icons.brightness_3,
      "description": "Unwind after work",
    },
    {
      "label": "Before Bed (9-11 PM)",
      "value": "night",
      "icon": Icons.bedtime,
      "description": "Prepare for peaceful sleep",
    },
    {
      "label": "Flexible",
      "value": "flexible",
      "icon": Icons.schedule,
      "description": "Whenever you have time",
    },
  ];

  List<Map<String, dynamic>> personalizedRecommendations = [
    {
      "title": "Sleep Preparation Routine",
      "duration": "15 min",
      "description": "Based on your goal of better sleep",
      "type": "Guided Meditation",
      "icon": Icons.bedtime,
      "color": primaryColor,
    },
    {
      "title": "Morning Awakening",
      "duration": "10 min",
      "description": "Perfect for your morning schedule",
      "type": "Breathing Exercise",
      "icon": Icons.wb_sunny,
      "color": warningColor,
    },
    {
      "title": "Body Scan for Sleep",
      "duration": "20 min",
      "description": "Deep relaxation technique",
      "type": "Progressive Relaxation",
      "icon": Icons.accessibility_new,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meditation Preferences"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.help_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withAlpha(20),
                    primaryColor.withAlpha(5),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.settings_suggest,
                    size: 48,
                    color: primaryColor,
                  ),
                  Text(
                    "Personalize Your Journey",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Help us customize your meditation experience to achieve your goals",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Meditation Goal
            Text(
              "What's your main meditation goal?",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Column(
              spacing: spSm,
              children: goalOptions.map((goal) {
                bool isSelected = meditationGoal == goal["value"];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      meditationGoal = goal["value"];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? (goal["color"] as Color).withAlpha(10)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected 
                            ? goal["color"] as Color
                            : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (goal["color"] as Color).withAlpha(
                              isSelected ? 40 : 20
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            goal["icon"] as IconData,
                            color: goal["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${goal["label"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected 
                                      ? goal["color"] as Color
                                      : primaryColor,
                                ),
                              ),
                              Text(
                                "${goal["description"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: goal["color"] as Color,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Daily Duration
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
                    "Daily meditation goal",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "5 min",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: primaryColor,
                            inactiveTrackColor: disabledColor,
                            thumbColor: primaryColor,
                            trackHeight: 4,
                          ),
                          child: Slider(
                            value: dailyMinutes.toDouble(),
                            min: 5,
                            max: 60,
                            divisions: 11,
                            onChanged: (value) {
                              setState(() {
                                dailyMinutes = value.round();
                              });
                            },
                          ),
                        ),
                      ),
                      Text(
                        "60 min",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$dailyMinutes minutes daily",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Preferred Time
            Text(
              "When do you prefer to meditate?",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QHorizontalScroll(
              children: timeOptions.map((time) {
                bool isSelected = preferredTime == time["value"];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      preferredTime = time["value"];
                    });
                  },
                  child: Container(
                    width: 160,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? primaryColor.withAlpha(20)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected 
                            ? primaryColor
                            : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(
                              isSelected ? 40 : 20
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            time["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        Text(
                          "${time["label"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${time["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Reminders Settings
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
                    "Reminder Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Daily Reminders",
                              "value": true,
                              "checked": remindersEnabled,
                            }
                          ],
                          value: [
                            if (remindersEnabled)
                              {
                                "label": "Daily Reminders",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            setState(() {
                              remindersEnabled = values.isNotEmpty;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  if (remindersEnabled) ...[
                    QTimePicker(
                      label: "Reminder Time",
                      value: TimeOfDay(
                        hour: int.parse(reminderTime.split(':')[0]),
                        minute: int.parse(reminderTime.split(':')[1]),
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            reminderTime = value.kkmm;
                          });
                        }
                      },
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Include Weekends",
                                "value": true,
                                "checked": weekendReminders,
                              }
                            ],
                            value: [
                              if (weekendReminders)
                                {
                                  "label": "Include Weekends",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                weekendReminders = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Personalized Recommendations
            Text(
              "Recommended for You",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Column(
              spacing: spSm,
              children: personalizedRecommendations.map((recommendation) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: (recommendation["color"] as Color).withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: (recommendation["color"] as Color).withAlpha(30),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (recommendation["color"] as Color).withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          recommendation["icon"] as IconData,
                          color: recommendation["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${recommendation["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${recommendation["description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              spacing: spSm,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (recommendation["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${recommendation["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: recommendation["color"] as Color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${recommendation["duration"]}",
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
                      QButton(
                        label: "Try",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Save Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Preferences",
                size: bs.md,
                onPressed: () {
                  ss("Preferences saved successfully!");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

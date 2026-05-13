import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaMedicationReminderView extends StatefulWidget {
  const MhaMedicationReminderView({super.key});

  @override
  State<MhaMedicationReminderView> createState() => _MhaMedicationReminderViewState();
}

class _MhaMedicationReminderViewState extends State<MhaMedicationReminderView> {
  String selectedMedication = "";
  String selectedFrequency = "daily";
  String selectedTime = "08:00";
  String notes = "";
  bool notificationsEnabled = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  String snoozeTime = "5";

  final List<Map<String, dynamic>> medications = [
    {
      "id": "1",
      "name": "Aspirin",
      "dosage": "100mg",
      "frequency": "daily",
      "times": ["08:00"],
      "nextDue": "2024-01-15 08:00",
      "taken": false,
      "streakDays": 15,
      "totalDoses": 30,
      "takenDoses": 28,
      "color": Colors.blue,
      "shape": "round",
      "notes": "Take with food",
    },
    {
      "id": "2",
      "name": "Vitamin D",
      "dosage": "1000 IU",
      "frequency": "daily",
      "times": ["09:00"],
      "nextDue": "2024-01-15 09:00",
      "taken": true,
      "streakDays": 22,
      "totalDoses": 60,
      "takenDoses": 58,
      "color": Colors.orange,
      "shape": "capsule",
      "notes": "Best absorbed with fats",
    },
    {
      "id": "3",
      "name": "Lisinopril",
      "dosage": "10mg",
      "frequency": "twice_daily",
      "times": ["08:00", "20:00"],
      "nextDue": "2024-01-15 20:00",
      "taken": false,
      "streakDays": 8,
      "totalDoses": 20,
      "takenDoses": 19,
      "color": Colors.red,
      "shape": "oval",
      "notes": "Monitor blood pressure",
    },
    {
      "id": "4",
      "name": "Metformin",
      "dosage": "500mg",
      "frequency": "twice_daily",
      "times": ["07:30", "19:30"],
      "nextDue": "2024-01-15 19:30",
      "taken": false,
      "streakDays": 12,
      "totalDoses": 40,
      "takenDoses": 37,
      "color": Colors.green,
      "shape": "round",
      "notes": "Take with meals",
    },
  ];

  final List<Map<String, dynamic>> todayReminders = [
    {
      "id": "1",
      "medication": "Aspirin",
      "dosage": "100mg",
      "time": "08:00",
      "status": "missed",
      "scheduledTime": "08:00",
      "actualTime": null,
    },
    {
      "id": "2",
      "medication": "Vitamin D",
      "dosage": "1000 IU",
      "time": "09:00",
      "status": "taken",
      "scheduledTime": "09:00",
      "actualTime": "09:05",
    },
    {
      "id": "3",
      "medication": "Lisinopril",
      "dosage": "10mg",
      "time": "20:00",
      "status": "upcoming",
      "scheduledTime": "20:00",
      "actualTime": null,
    },
    {
      "id": "4",
      "medication": "Metformin",
      "dosage": "500mg",
      "time": "19:30",
      "status": "upcoming",
      "scheduledTime": "19:30",
      "actualTime": null,
    },
  ];

  final List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Once Daily", "value": "daily"},
    {"label": "Twice Daily", "value": "twice_daily"},
    {"label": "Three Times Daily", "value": "three_times_daily"},
    {"label": "Every 6 Hours", "value": "every_6_hours"},
    {"label": "Every 8 Hours", "value": "every_8_hours"},
    {"label": "As Needed", "value": "as_needed"},
    {"label": "Weekly", "value": "weekly"},
  ];

  final List<Map<String, dynamic>> snoozeOptions = [
    {"label": "5 minutes", "value": "5"},
    {"label": "10 minutes", "value": "10"},
    {"label": "15 minutes", "value": "15"},
    {"label": "30 minutes", "value": "30"},
    {"label": "1 hour", "value": "60"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medication Reminders"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showSettingsBottomSheet();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTodayOverview(),
            SizedBox(height: spLg),
            _buildUpcomingReminders(),
            SizedBox(height: spLg),
            _buildMedicationList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddReminderBottomSheet();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTodayOverview() {
    final taken = todayReminders.where((r) => r["status"] == "taken").length;
    final missed = todayReminders.where((r) => r["status"] == "missed").length;
    final upcoming = todayReminders.where((r) => r["status"] == "upcoming").length;
    final adherencePercentage = ((taken / todayReminders.length) * 100).round();

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
          Text(
            "Today's Progress",
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "$taken",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "Taken",
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
                    color: Colors.red.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.cancel, color: Colors.red, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "$missed",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "Missed",
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
                    color: Colors.orange.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.schedule, color: Colors.orange, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "$upcoming",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        "Upcoming",
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
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Adherence Rate: $adherencePercentage%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingReminders() {
    final upcomingReminders = todayReminders
        .where((r) => r["status"] == "upcoming")
        .toList();

    if (upcomingReminders.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upcoming Reminders",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...upcomingReminders.map((reminder) => _buildReminderCard(reminder)),
      ],
    );
  }

  Widget _buildReminderCard(Map<String, dynamic> reminder) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(reminder["status"]),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _getStatusColor(reminder["status"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getStatusIcon(reminder["status"]),
              color: _getStatusColor(reminder["status"]),
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${reminder["medication"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${reminder["dosage"]} at ${reminder["time"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (reminder["status"] == "upcoming") ...[
            QButton(
              label: "Take Now",
              size: bs.sm,
              onPressed: () {
                _markAsTaken(reminder["id"]);
              },
            ),
          ] else if (reminder["status"] == "taken") ...[
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24,
            ),
          ] else if (reminder["status"] == "missed") ...[
            QButton(
              label: "Mark Taken",
              size: bs.sm,
              onPressed: () {
                _markAsTaken(reminder["id"]);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMedicationList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Medications",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Add New",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                _showAddReminderBottomSheet();
              },
            ),
          ],
        ),
        SizedBox(height: spSm),
        ...medications.map((medication) => _buildMedicationCard(medication)),
      ],
    );
  }

  Widget _buildMedicationCard(Map<String, dynamic> medication) {
    final adherence = ((medication["takenDoses"] as int) / (medication["totalDoses"] as int) * 100).round();
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (medication["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.medication,
                  color: medication["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${medication["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${medication["dosage"]} - ${_getFrequencyLabel(medication["frequency"])}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Streak",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${medication["streakDays"]} days",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Adherence",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$adherence%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: adherence >= 80 ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Next Dose",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(medication["times"] as List)[0]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (medication["notes"].isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${medication["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddReminderBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Medication Reminder",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: disabledBoldColor),
                ),
              ],
            ),
            SizedBox(height: spLg),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    QTextField(
                      label: "Medication Name",
                      value: selectedMedication,
                      hint: "Enter medication name",
                      onChanged: (value) {
                        selectedMedication = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Frequency",
                      items: frequencyOptions,
                      value: selectedFrequency,
                      onChanged: (value, label) {
                        selectedFrequency = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QTimePicker(
                      label: "Reminder Time",
                      value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-15 $selectedTime")),
                      onChanged: (value) {
                        selectedTime = value!.kkmm;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QMemoField(
                      label: "Notes (Optional)",
                      value: notes,
                      hint: "Special instructions, food requirements, etc.",
                      onChanged: (value) {
                        notes = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spLg),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Add Reminder",
                        onPressed: () {
                          Navigator.pop(context);
                          ss("Medication reminder added successfully");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reminder Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spLg),
            QSwitch(
              label: "Enable Notifications",
              items: [
                {
                  "label": "Enable push notifications for medication reminders",
                  "value": true,
                  "checked": notificationsEnabled,
                }
              ],
              value: [
                if (notificationsEnabled)
                  {
                    "label": "Enable push notifications for medication reminders",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  notificationsEnabled = values.isNotEmpty;
                });
              },
            ),
            SizedBox(height: spSm),
            QSwitch(
              label: "Sound Alerts",
              items: [
                {
                  "label": "Play sound with notifications",
                  "value": true,
                  "checked": soundEnabled,
                }
              ],
              value: [
                if (soundEnabled)
                  {
                    "label": "Play sound with notifications",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  soundEnabled = values.isNotEmpty;
                });
              },
            ),
            SizedBox(height: spSm),
            QSwitch(
              label: "Vibration",
              items: [
                {
                  "label": "Vibrate device for alerts",
                  "value": true,
                  "checked": vibrationEnabled,
                }
              ],
              value: [
                if (vibrationEnabled)
                  {
                    "label": "Vibrate device for alerts",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  vibrationEnabled = values.isNotEmpty;
                });
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Snooze Duration",
              items: snoozeOptions,
              value: snoozeTime,
              onChanged: (value, label) {
                snoozeTime = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Settings",
                onPressed: () {
                  Navigator.pop(context);
                  ss("Settings saved successfully");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markAsTaken(String reminderId) {
    setState(() {
      final reminderIndex = todayReminders.indexWhere((r) => r["id"] == reminderId);
      if (reminderIndex != -1) {
        todayReminders[reminderIndex]["status"] = "taken";
        todayReminders[reminderIndex]["actualTime"] = TimeOfDay.now().kkmm;
      }
    });
    ss("Medication marked as taken");
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "taken":
        return Colors.green;
      case "missed":
        return Colors.red;
      case "upcoming":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "taken":
        return Icons.check_circle;
      case "missed":
        return Icons.cancel;
      case "upcoming":
        return Icons.schedule;
      default:
        return Icons.medication;
    }
  }

  String _getFrequencyLabel(String frequency) {
    switch (frequency) {
      case "daily":
        return "Once daily";
      case "twice_daily":
        return "Twice daily";
      case "three_times_daily":
        return "Three times daily";
      case "every_6_hours":
        return "Every 6 hours";
      case "every_8_hours":
        return "Every 8 hours";
      case "as_needed":
        return "As needed";
      case "weekly":
        return "Weekly";
      default:
        return frequency;
    }
  }
}

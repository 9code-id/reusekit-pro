import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaMedicationRemindersView extends StatefulWidget {
  const HcaMedicationRemindersView({super.key});

  @override
  State<HcaMedicationRemindersView> createState() => _HcaMedicationRemindersViewState();
}

class _HcaMedicationRemindersViewState extends State<HcaMedicationRemindersView> {
  String searchQuery = "";
  String selectedFilter = "All";
  bool showAddReminderModal = false;
  
  // New reminder form fields
  String medicationName = "";
  String dosage = "";
  String frequency = "Once Daily";
  String reminderTime = "08:00";
  String instructions = "";
  String duration = "7";
  bool withFood = false;
  
  List<Map<String, dynamic>> reminders = [
    {
      "id": 1,
      "medication": "Amoxicillin",
      "dosage": "500mg",
      "frequency": "3 times daily",
      "times": ["08:00", "14:00", "20:00"],
      "nextDose": "14:00",
      "status": "active",
      "instructions": "Take with food",
      "remaining": 5,
      "totalDays": 7,
      "color": successColor,
      "icon": Icons.medication,
      "lastTaken": "08:00 - Today",
      "sideEffects": ["Nausea", "Diarrhea"],
      "type": "Antibiotic"
    },
    {
      "id": 2,
      "medication": "Lisinopril",
      "dosage": "10mg",
      "frequency": "Once daily",
      "times": ["09:00"],
      "nextDose": "09:00",
      "status": "missed",
      "instructions": "Take on empty stomach",
      "remaining": 30,
      "totalDays": 30,
      "color": dangerColor,
      "icon": Icons.favorite,
      "lastTaken": "Yesterday",
      "sideEffects": ["Dry cough", "Dizziness"],
      "type": "Blood Pressure"
    },
    {
      "id": 3,
      "medication": "Metformin",
      "dosage": "850mg",
      "frequency": "2 times daily",
      "times": ["07:00", "19:00"],
      "nextDose": "19:00",
      "status": "taken",
      "instructions": "Take with meals",
      "remaining": 25,
      "totalDays": 30,
      "color": infoColor,
      "icon": Icons.healing,
      "lastTaken": "07:00 - Today",
      "sideEffects": ["Stomach upset", "Metallic taste"],
      "type": "Diabetes"
    },
    {
      "id": 4,
      "medication": "Vitamin D3",
      "dosage": "2000 IU",
      "frequency": "Once daily",
      "times": ["10:00"],
      "nextDose": "10:00",
      "status": "upcoming",
      "instructions": "Take with food for better absorption",
      "remaining": 60,
      "totalDays": 90,
      "color": warningColor,
      "icon": Icons.wb_sunny,
      "lastTaken": "Yesterday",
      "sideEffects": [],
      "type": "Supplement"
    },
    {
      "id": 5,
      "medication": "Ibuprofen",
      "dosage": "400mg",
      "frequency": "As needed",
      "times": ["As needed"],
      "nextDose": "As needed",
      "status": "as_needed",
      "instructions": "Take with food. Max 3 times daily",
      "remaining": 20,
      "totalDays": 0,
      "color": primaryColor,
      "icon": Icons.healing,
      "lastTaken": "2 days ago",
      "sideEffects": ["Stomach irritation"],
      "type": "Pain Relief"
    }
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Once Daily", "value": "Once Daily"},
    {"label": "Twice Daily", "value": "Twice Daily"},
    {"label": "3 Times Daily", "value": "3 Times Daily"},
    {"label": "4 Times Daily", "value": "4 Times Daily"},
    {"label": "As Needed", "value": "As Needed"},
  ];

  List<String> filterOptions = ["All", "Active", "Missed", "Taken", "Upcoming", "As Needed"];

  List<Map<String, dynamic>> get filteredReminders {
    List<Map<String, dynamic>> filtered = reminders;
    
    if (selectedFilter != "All") {
      String filterStatus = selectedFilter.toLowerCase().replaceAll(" ", "_");
      filtered = filtered.where((reminder) => reminder["status"] == filterStatus).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((reminder) =>
        reminder["medication"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        reminder["type"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medication Reminders"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddReminderModal(),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _showScheduleView(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilter(),
            _buildQuickStats(),
            _buildTodaySchedule(),
            _buildRemindersList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search medications",
          value: searchQuery,
          hint: "Search by medication name or type",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
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
      ],
    );
  }

  Widget _buildQuickStats() {
    int activeCount = reminders.where((r) => r["status"] == "active").length;
    int missedCount = reminders.where((r) => r["status"] == "missed").length;
    int takenTodayCount = reminders.where((r) => r["status"] == "taken").length;
    int upcomingCount = reminders.where((r) => r["status"] == "upcoming").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 150,
      children: [
        _buildStatCard("Active", "$activeCount", successColor, Icons.medication),
        _buildStatCard("Missed", "$missedCount", dangerColor, Icons.warning),
        _buildStatCard("Taken Today", "$takenTodayCount", infoColor, Icons.check_circle),
        _buildStatCard("Upcoming", "$upcomingCount", warningColor, Icons.schedule),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySchedule() {
    List<Map<String, dynamic>> todayReminders = reminders.where((r) => r["times"] != null && r["times"].isNotEmpty).toList();
    todayReminders.sort((a, b) => a["nextDose"].compareTo(b["nextDose"]));

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.today, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "Today's Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...todayReminders.take(3).map((reminder) => _buildScheduleItem(reminder)),
          if (todayReminders.length > 3)
            GestureDetector(
              onTap: () => _showScheduleView(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spXs),
                child: Text(
                  "View all ${todayReminders.length} reminders",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(Map<String, dynamic> reminder) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: (reminder["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border(
          left: BorderSide(
            width: 3,
            color: reminder["color"] as Color,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            "${reminder["nextDose"]}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: reminder["color"] as Color,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${reminder["medication"]} - ${reminder["dosage"]}",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  "${reminder["instructions"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            _getStatusIcon(reminder["status"]),
            color: reminder["color"] as Color,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildRemindersList() {
    if (filteredReminders.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.medication_liquid,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No reminders found",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Add your first medication reminder",
              style: TextStyle(color: disabledColor),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All Reminders (${filteredReminders.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        ...filteredReminders.map((reminder) => _buildReminderCard(reminder)),
      ],
    );
  }

  Widget _buildReminderCard(Map<String, dynamic> reminder) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: reminder["color"] as Color,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (reminder["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  reminder["icon"] as IconData,
                  color: reminder["color"] as Color,
                  size: 24,
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
                          "${reminder["medication"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (reminder["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusText(reminder["status"]),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: reminder["color"] as Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${reminder["dosage"]} • ${reminder["frequency"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${reminder["type"]}",
                      style: TextStyle(
                        color: disabledColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Next: ${reminder["nextDose"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${reminder["remaining"]} pills left",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Mark Taken",
                  size: bs.sm,
                  onPressed: () => _markAsTaken(reminder),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showReminderOptions(reminder),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "taken":
        return Icons.check_circle;
      case "missed":
        return Icons.warning;
      case "upcoming":
        return Icons.schedule;
      case "as_needed":
        return Icons.help_outline;
      default:
        return Icons.medication;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "taken":
        return "TAKEN";
      case "missed":
        return "MISSED";
      case "upcoming":
        return "UPCOMING";
      case "as_needed":
        return "AS NEEDED";
      default:
        return "ACTIVE";
    }
  }

  void _showAddReminderModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Add Medication Reminder",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              QTextField(
                label: "Medication Name",
                value: medicationName,
                hint: "Enter medication name",
                onChanged: (value) {
                  medicationName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Dosage",
                value: dosage,
                hint: "e.g., 500mg, 1 tablet",
                onChanged: (value) {
                  dosage = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Frequency",
                items: frequencyOptions,
                value: frequency,
                onChanged: (value, label) {
                  frequency = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTimePicker(
                label: "Reminder Time",
                value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $reminderTime:00")),
                onChanged: (value) {
                  reminderTime = value!.kkmm;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Duration (days)",
                value: duration,
                hint: "Number of days to take medication",
                onChanged: (value) {
                  duration = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Special Instructions",
                value: instructions,
                hint: "e.g., Take with food, on empty stomach",
                onChanged: (value) {
                  instructions = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QSwitch(
                items: [
                  {
                    "label": "Take with food",
                    "value": true,
                    "checked": withFood,
                  }
                ],
                value: [if (withFood) {"label": "Take with food", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  withFood = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.md,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Add Reminder",
                      size: bs.md,
                      onPressed: () => _addReminder(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showScheduleView() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Today's Full Schedule",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              ...reminders.map((reminder) => _buildDetailedScheduleItem(reminder)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailedScheduleItem(Map<String, dynamic> reminder) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (reminder["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: reminder["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${reminder["nextDose"]}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: reminder["color"] as Color,
                ),
              ),
              Spacer(),
              Icon(
                _getStatusIcon(reminder["status"]),
                color: reminder["color"] as Color,
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${reminder["medication"]} - ${reminder["dosage"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "${reminder["instructions"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          if ((reminder["sideEffects"] as List).isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              "Side effects: ${(reminder["sideEffects"] as List).join(", ")}",
              style: TextStyle(
                color: warningColor,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showReminderOptions(Map<String, dynamic> reminder) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${reminder["medication"]} Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.edit, color: primaryColor),
              title: Text("Edit Reminder"),
              onTap: () {
                Navigator.pop(context);
                // Navigate to edit
              },
            ),
            ListTile(
              leading: Icon(Icons.pause, color: warningColor),
              title: Text("Pause Reminder"),
              onTap: () {
                Navigator.pop(context);
                // Pause logic
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: infoColor),
              title: Text("View History"),
              onTap: () {
                Navigator.pop(context);
                // View history
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Reminder"),
              onTap: () {
                Navigator.pop(context);
                _deleteReminder(reminder);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addReminder() {
    if (medicationName.isEmpty || dosage.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    Map<String, dynamic> newReminder = {
      "id": reminders.length + 1,
      "medication": medicationName,
      "dosage": dosage,
      "frequency": frequency,
      "times": [reminderTime],
      "nextDose": reminderTime,
      "status": "active",
      "instructions": instructions.isEmpty ? "No special instructions" : instructions,
      "remaining": int.tryParse(duration) ?? 7,
      "totalDays": int.tryParse(duration) ?? 7,
      "color": primaryColor,
      "icon": Icons.medication,
      "lastTaken": "Not taken yet",
      "sideEffects": [],
      "type": "Prescription"
    };

    reminders.add(newReminder);
    
    // Reset form
    medicationName = "";
    dosage = "";
    frequency = "Once Daily";
    reminderTime = "08:00";
    instructions = "";
    duration = "7";
    withFood = false;
    
    setState(() {});
    Navigator.pop(context);
    ss("Medication reminder added successfully");
  }

  void _markAsTaken(Map<String, dynamic> reminder) {
    reminder["status"] = "taken";
    reminder["lastTaken"] = "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')} - Today";
    reminder["remaining"] = (reminder["remaining"] as int) - 1;
    setState(() {});
    ss("Marked ${reminder["medication"]} as taken");
  }

  void _deleteReminder(Map<String, dynamic> reminder) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this reminder?");
    if (isConfirmed) {
      reminders.removeWhere((r) => r["id"] == reminder["id"]);
      setState(() {});
      ss("Reminder deleted successfully");
    }
  }
}

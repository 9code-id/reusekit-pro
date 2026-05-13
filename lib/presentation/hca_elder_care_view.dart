import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaElderCareView extends StatefulWidget {
  const HcaElderCareView({super.key});

  @override
  State<HcaElderCareView> createState() => _HcaElderCareViewState();
}

class _HcaElderCareViewState extends State<HcaElderCareView> {
  String selectedElder = "Margaret Johnson (82)";
  
  List<Map<String, dynamic>> elders = [
    {"label": "Margaret Johnson (82)", "value": "margaret", "age": 82},
    {"label": "Robert Wilson (78)", "value": "robert", "age": 78},
    {"label": "Dorothy Brown (85)", "value": "dorothy", "age": 85},
  ];
  
  List<Map<String, dynamic>> todayTasks = [
    {
      "time": "8:00 AM",
      "task": "Morning Medication",
      "medications": ["Metformin", "Lisinopril"],
      "completed": true,
      "type": "medication"
    },
    {
      "time": "10:00 AM",
      "task": "Blood Pressure Check",
      "reading": "125/80",
      "completed": true,
      "type": "vitals"
    },
    {
      "time": "12:00 PM",
      "task": "Lunch Assistance",
      "notes": "Needs help with eating",
      "completed": false,
      "type": "care"
    },
    {
      "time": "2:00 PM",
      "task": "Physical Therapy",
      "duration": "30 minutes",
      "completed": false,
      "type": "therapy"
    },
    {
      "time": "6:00 PM",
      "task": "Evening Medication",
      "medications": ["Calcium", "Vitamin D"],
      "completed": false,
      "type": "medication"
    },
  ];
  
  List<Map<String, dynamic>> healthMetrics = [
    {
      "title": "Blood Pressure",
      "value": "125/80",
      "status": "Normal",
      "lastCheck": "Today 10:00 AM",
      "icon": Icons.favorite,
      "color": successColor
    },
    {
      "title": "Heart Rate",
      "value": "72 bpm",
      "status": "Normal",
      "lastCheck": "Today 10:00 AM",
      "icon": Icons.monitor_heart,
      "color": successColor
    },
    {
      "title": "Blood Sugar",
      "value": "110 mg/dL",
      "status": "Normal",
      "lastCheck": "Yesterday",
      "icon": Icons.water_drop,
      "color": successColor
    },
    {
      "title": "Temperature",
      "value": "98.6°F",
      "status": "Normal",
      "lastCheck": "Today 8:00 AM",
      "icon": Icons.thermostat,
      "color": successColor
    },
  ];
  
  List<Map<String, dynamic>> upcomingAppointments = [
    {
      "date": "Dec 22, 2024",
      "time": "2:00 PM",
      "doctor": "Dr. Sarah Miller",
      "specialty": "Cardiologist",
      "type": "Follow-up",
      "location": "Heart Center"
    },
    {
      "date": "Dec 28, 2024",
      "time": "10:30 AM",
      "doctor": "Dr. James Chen",
      "specialty": "Primary Care",
      "type": "Routine Check-up",
      "location": "Main Clinic"
    },
  ];
  
  List<Map<String, dynamic>> careNotes = [
    {
      "date": "Today",
      "time": "10:15 AM",
      "caregiver": "Nurse Linda",
      "note": "Blood pressure reading normal. Patient in good spirits.",
      "type": "vitals"
    },
    {
      "date": "Yesterday",
      "time": "6:30 PM",
      "caregiver": "Aide Tom",
      "note": "Assistance with dinner. Ate well, good appetite.",
      "type": "care"
    },
    {
      "date": "Dec 17",
      "time": "2:00 PM",
      "caregiver": "PT Sarah",
      "note": "Physical therapy session completed. Good progress with mobility.",
      "type": "therapy"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Elder Care"),
        actions: [
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
            _buildElderSelector(),
            _buildQuickStats(),
            _buildTodaySchedule(),
            _buildHealthMetrics(),
            _buildUpcomingAppointments(),
            _buildCareNotes(),
          ],
        ),
      ),
    );
  }

  Widget _buildElderSelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: QDropdownField(
        label: "Select Elder",
        items: elders,
        value: selectedElder,
        onChanged: (value, label) {
          selectedElder = label!;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildQuickStats() {
    int completedTasks = todayTasks.where((task) => task["completed"]).length;
    int totalTasks = todayTasks.length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.elderly,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedElder,
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Daily Care Overview",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
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
              _buildQuickStatItem("Tasks\nCompleted", "$completedTasks/$totalTasks"),
              _buildQuickStatItem("Health\nStatus", "Stable"),
              _buildQuickStatItem("Next\nMedication", "6:00 PM"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatItem(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(50),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(200),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaySchedule() {
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
                "Today's Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...todayTasks.map((task) => _buildTaskItem(task)),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    Color taskColor = _getTaskColor(task["type"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: task["completed"] ? taskColor.withAlpha(25) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: task["completed"] ? taskColor.withAlpha(100) : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: task["completed"] ? taskColor : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              task["completed"] ? Icons.check : _getTaskIcon(task["type"]),
              color: Colors.white,
              size: 16,
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
                    Text(
                      "${task["task"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: task["completed"] ? taskColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if (task["medications"] != null) ...[
                  Text(
                    "${(task["medications"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
                if (task["reading"] != null) ...[
                  Text(
                    "Reading: ${task["reading"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
                if (task["notes"] != null) ...[
                  Text(
                    "${task["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (!task["completed"]) ...[
            QButton(
              label: "Complete",
              size: bs.sm,
              onPressed: () {
                task["completed"] = true;
                setState(() {});
                ss("Task marked as completed");
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHealthMetrics() {
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
                Icons.health_and_safety,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Health Metrics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: healthMetrics.map((metric) => _buildMetricCard(metric)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (metric["color"] as Color).withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (metric["color"] as Color).withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                metric["icon"],
                color: metric["color"] as Color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${metric["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: metric["color"] as Color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${metric["value"]}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: metric["color"] as Color,
            ),
          ),
          Text(
            "${metric["status"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Last: ${metric["lastCheck"]}",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
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
                Icons.calendar_today,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Upcoming Appointments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...upcomingAppointments.map((appointment) => _buildAppointmentItem(appointment)),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(Map<String, dynamic> appointment) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: infoColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.local_hospital,
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
                  "${appointment["doctor"]} - ${appointment["specialty"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
                Text(
                  "${appointment["date"]} at ${appointment["time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${appointment["type"]} • ${appointment["location"]}",
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
    );
  }

  Widget _buildCareNotes() {
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
                Icons.note_alt,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Care Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Note",
                size: bs.sm,
                onPressed: () {
                  _showAddNoteDialog();
                },
              ),
            ],
          ),
          ...careNotes.map((note) => _buildCareNoteItem(note)),
        ],
      ),
    );
  }

  Widget _buildCareNoteItem(Map<String, dynamic> note) {
    Color noteColor = _getTaskColor(note["type"]);
    
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
            width: 8,
            height: 8,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: noteColor,
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
                      "${note["date"]} ${note["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: noteColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${note["caregiver"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${note["note"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTaskColor(String type) {
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

  IconData _getTaskIcon(String type) {
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

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emergency, color: dangerColor),
            SizedBox(width: spSm),
            Text("Emergency Contacts"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(height: spSm),
            QButton(
              label: "Call Primary Doctor",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                ss("Doctor contacted");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Call Family Member",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                ss("Family member contacted");
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

  void _showAddNoteDialog() {
    String note = "";
    String caregiverName = "";
    String noteType = "care";
    
    List<Map<String, dynamic>> noteTypes = [
      {"label": "Care", "value": "care"},
      {"label": "Vitals", "value": "vitals"},
      {"label": "Medication", "value": "medication"},
      {"label": "Therapy", "value": "therapy"},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Care Note"),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Caregiver Name",
                value: caregiverName,
                onChanged: (value) {
                  caregiverName = value;
                  setDialogState(() {});
                },
              ),
              QDropdownField(
                label: "Category",
                items: noteTypes,
                value: noteType,
                onChanged: (value, label) {
                  noteType = value;
                  setDialogState(() {});
                },
              ),
              QMemoField(
                label: "Care Note",
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
              ss("Care note added successfully");
            },
          ),
        ],
      ),
    );
  }
}

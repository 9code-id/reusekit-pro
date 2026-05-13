import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaSymptomTrackerView extends StatefulWidget {
  const MhaSymptomTrackerView({super.key});

  @override
  State<MhaSymptomTrackerView> createState() => _MhaSymptomTrackerViewState();
}

class _MhaSymptomTrackerViewState extends State<MhaSymptomTrackerView> {
  String selectedSymptom = "headache";
  String selectedSeverity = "moderate";
  String selectedDuration = "2-4 hours";
  String notes = "";
  List<String> selectedTriggers = [];
  bool showAddForm = false;

  final List<Map<String, dynamic>> symptoms = [
    {
      "id": "1",
      "name": "Headache",
      "type": "headache",
      "severity": "moderate",
      "duration": "3 hours",
      "date": "2024-01-15",
      "time": "14:30",
      "triggers": ["stress", "lack_of_sleep"],
      "notes": "Started after working long hours on computer",
      "status": "resolved",
      "color": Colors.orange,
    },
    {
      "id": "2",
      "name": "Back Pain",
      "type": "back_pain",
      "severity": "severe",
      "duration": "ongoing",
      "date": "2024-01-14",
      "time": "09:15",
      "triggers": ["poor_posture", "heavy_lifting"],
      "notes": "Lower back pain after moving furniture",
      "status": "ongoing",
      "color": Colors.red,
    },
    {
      "id": "3",
      "name": "Fatigue",
      "type": "fatigue",
      "severity": "mild",
      "duration": "all day",
      "date": "2024-01-13",
      "time": "07:00",
      "triggers": ["poor_sleep", "stress"],
      "notes": "Feeling tired despite 8 hours of sleep",
      "status": "improving",
      "color": Colors.yellow,
    },
    {
      "id": "4",
      "name": "Nausea",
      "type": "nausea",
      "severity": "moderate",
      "duration": "1 hour",
      "date": "2024-01-12",
      "time": "12:00",
      "triggers": ["medication", "empty_stomach"],
      "notes": "Occurred after taking medication without food",
      "status": "resolved",
      "color": Colors.green,
    },
  ];

  final List<Map<String, dynamic>> symptomTypes = [
    {"label": "Headache", "value": "headache", "icon": Icons.psychology},
    {"label": "Back Pain", "value": "back_pain", "icon": Icons.accessibility_new},
    {"label": "Chest Pain", "value": "chest_pain", "icon": Icons.favorite},
    {"label": "Fatigue", "value": "fatigue", "icon": Icons.battery_0_bar},
    {"label": "Nausea", "value": "nausea", "icon": Icons.sick},
    {"label": "Dizziness", "value": "dizziness", "icon": Icons.rotate_right},
    {"label": "Joint Pain", "value": "joint_pain", "icon": Icons.sports_handball},
    {"label": "Stomach Ache", "value": "stomach_ache", "icon": Icons.local_dining},
  ];

  final List<Map<String, dynamic>> severityLevels = [
    {"label": "Mild", "value": "mild", "color": Colors.green},
    {"label": "Moderate", "value": "moderate", "color": Colors.orange},
    {"label": "Severe", "value": "severe", "color": Colors.red},
    {"label": "Very Severe", "value": "very_severe", "color": Colors.purple},
  ];

  final List<Map<String, dynamic>> durationOptions = [
    {"label": "Less than 30 minutes", "value": "< 30 min"},
    {"label": "30 minutes - 1 hour", "value": "30-60 min"},
    {"label": "1-2 hours", "value": "1-2 hours"},
    {"label": "2-4 hours", "value": "2-4 hours"},
    {"label": "4-8 hours", "value": "4-8 hours"},
    {"label": "More than 8 hours", "value": "> 8 hours"},
    {"label": "All day", "value": "all day"},
    {"label": "Ongoing", "value": "ongoing"},
  ];

  final List<Map<String, dynamic>> triggerOptions = [
    {"label": "Stress", "value": "stress"},
    {"label": "Lack of Sleep", "value": "lack_of_sleep"},
    {"label": "Poor Posture", "value": "poor_posture"},
    {"label": "Heavy Lifting", "value": "heavy_lifting"},
    {"label": "Weather Change", "value": "weather"},
    {"label": "Medication", "value": "medication"},
    {"label": "Food", "value": "food"},
    {"label": "Exercise", "value": "exercise"},
    {"label": "Dehydration", "value": "dehydration"},
    {"label": "Screen Time", "value": "screen_time"},
  ];

  List<Map<String, dynamic>> get filteredSymptoms {
    return symptoms.where((symptom) {
      return symptom["type"] == selectedSymptom ||
             selectedSymptom.isEmpty;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Symptom Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                showAddForm = true;
              });
            },
          ),
        ],
      ),
      body: showAddForm ? _buildAddSymptomForm() : _buildSymptomList(),
    );
  }

  Widget _buildSymptomList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickStats(),
          SizedBox(height: spLg),
          _buildFilterSection(),
          SizedBox(height: spLg),
          _buildSymptomHistory(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
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
            "Today's Summary",
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
                child: _buildStatCard(
                  "Active Symptoms",
                  "${symptoms.where((s) => s["status"] == "ongoing").length}",
                  Icons.warning,
                  Colors.orange,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Resolved Today",
                  "${symptoms.where((s) => s["status"] == "resolved" && s["date"] == "2024-01-15").length}",
                  Icons.check_circle,
                  Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "This Week",
                  "${symptoms.length}",
                  Icons.calendar_today,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Most Common",
                  "Headache",
                  Icons.psychology,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
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
            "Filter Symptoms",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Symptom Type",
            items: [
              {"label": "All Symptoms", "value": ""},
              ...symptomTypes,
            ],
            value: selectedSymptom,
            onChanged: (value, label) {
              selectedSymptom = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Symptom History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Add Symptom",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                setState(() {
                  showAddForm = true;
                });
              },
            ),
          ],
        ),
        SizedBox(height: spSm),
        ...filteredSymptoms.map((symptom) => _buildSymptomCard(symptom)),
      ],
    );
  }

  Widget _buildSymptomCard(Map<String, dynamic> symptom) {
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
            color: symptom["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${symptom["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${symptom["date"]} at ${symptom["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getSeverityColor(symptom["severity"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${symptom["severity"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getSeverityColor(symptom["severity"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Duration: ${symptom["duration"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (symptom["notes"].isNotEmpty) ...[
            SizedBox(height: spSm),
            Text(
              "${symptom["notes"]}",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ],
          if ((symptom["triggers"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (symptom["triggers"] as List).map<Widget>((trigger) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    trigger.toString().replaceAll("_", " ").toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getStatusColor(symptom["status"]).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${symptom["status"]}".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(symptom["status"]),
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Edit symptom
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddSymptomForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Add New Symptom",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.close,
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    showAddForm = false;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: spLg),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QDropdownField(
                  label: "Symptom Type",
                  items: symptomTypes,
                  value: selectedSymptom,
                  onChanged: (value, label) {
                    selectedSymptom = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Severity Level",
                  items: severityLevels,
                  value: selectedSeverity,
                  onChanged: (value, label) {
                    selectedSeverity = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Duration",
                  items: durationOptions,
                  value: selectedDuration,
                  onChanged: (value, label) {
                    selectedDuration = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Text(
                  "Possible Triggers",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: triggerOptions.map((trigger) {
                    final isSelected = selectedTriggers.contains(trigger["value"]);
                    return GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          selectedTriggers.remove(trigger["value"]);
                        } else {
                          selectedTriggers.add(trigger["value"]);
                        }
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "${trigger["label"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spSm),
                QMemoField(
                  label: "Additional Notes",
                  value: notes,
                  hint: "Describe your symptom in more detail...",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spLg),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Save Symptom",
                    onPressed: () {
                      setState(() {
                        showAddForm = false;
                      });
                      ss("Symptom recorded successfully");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "mild":
        return Colors.green;
      case "moderate":
        return Colors.orange;
      case "severe":
        return Colors.red;
      case "very_severe":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "ongoing":
        return Colors.orange;
      case "resolved":
        return Colors.green;
      case "improving":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

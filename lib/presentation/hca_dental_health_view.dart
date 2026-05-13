import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaDentalHealthView extends StatefulWidget {
  const HcaDentalHealthView({super.key});

  @override
  State<HcaDentalHealthView> createState() => _HcaDentalHealthViewState();
}

class _HcaDentalHealthViewState extends State<HcaDentalHealthView> {
  int currentTab = 0;

  // Dental Records Data
  List<Map<String, dynamic>> dentalVisits = [
    {
      "id": "1",
      "date": "2024-05-15",
      "type": "Cleaning",
      "dentist": "Dr. Smith",
      "clinic": "SmileCare Dental",
      "procedures": ["Dental Cleaning", "Fluoride Treatment"],
      "cost": 150.0,
      "nextVisit": "2024-11-15",
      "notes": "Excellent oral hygiene. No cavities found.",
      "rating": 5,
    },
    {
      "id": "2",
      "date": "2024-02-20",
      "type": "Treatment",
      "dentist": "Dr. Johnson",
      "clinic": "SmileCare Dental",
      "procedures": ["Cavity Filling", "X-Ray"],
      "cost": 280.0,
      "nextVisit": "",
      "notes": "Filled cavity on upper left molar. No complications.",
      "rating": 4,
    },
    {
      "id": "3",
      "date": "2023-11-10",
      "type": "Cleaning",
      "dentist": "Dr. Smith",
      "clinic": "SmileCare Dental",
      "procedures": ["Dental Cleaning", "Oral Examination"],
      "cost": 120.0,
      "nextVisit": "",
      "notes": "Minor plaque buildup. Recommended better flossing.",
      "rating": 5,
    },
  ];

  // Oral Care Routine Data
  List<Map<String, dynamic>> todayRoutine = [
    {
      "activity": "Morning Brushing",
      "time": "07:30",
      "completed": true,
      "duration": 2,
    },
    {
      "activity": "Flossing",
      "time": "22:00",
      "completed": false,
      "duration": 1,
    },
    {
      "activity": "Mouthwash",
      "time": "22:05",
      "completed": false,
      "duration": 1,
    },
    {
      "activity": "Evening Brushing",
      "time": "22:10",
      "completed": false,
      "duration": 2,
    },
  ];

  // Form fields for dental visit
  String visitType = "";
  String dentistName = "";
  String clinicName = "";
  String procedures = "";
  DateTime visitDate = DateTime.now();
  double visitCost = 0.0;
  DateTime nextVisitDate = DateTime.now().add(Duration(days: 180));
  String visitNotes = "";
  int visitRating = 5;

  // Form fields for routine tracking
  bool morningBrushing = false;
  bool eveningBrushing = false;
  bool flossing = false;
  bool mouthwash = false;
  String oralCareNotes = "";

  List<Map<String, dynamic>> visitTypeItems = [
    {"label": "Select Type", "value": ""},
    {"label": "Cleaning", "value": "Cleaning"},
    {"label": "Treatment", "value": "Treatment"},
    {"label": "Checkup", "value": "Checkup"},
    {"label": "Emergency", "value": "Emergency"},
    {"label": "Orthodontic", "value": "Orthodontic"},
    {"label": "Surgery", "value": "Surgery"},
  ];

  Color _getVisitTypeColor(String type) {
    switch (type.toLowerCase()) {
      case "cleaning":
        return successColor;
      case "checkup":
        return infoColor;
      case "treatment":
        return warningColor;
      case "emergency":
        return dangerColor;
      case "orthodontic":
        return primaryColor;
      case "surgery":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  double _calculateAverageCost() {
    if (dentalVisits.isEmpty) return 0;
    double total = dentalVisits.fold(0.0, (sum, visit) => sum + (visit["cost"] as double));
    return total / dentalVisits.length;
  }

  int _getCompletedRoutineCount() {
    return todayRoutine.where((routine) => routine["completed"] == true).length;
  }

  Widget _buildVisitsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${dentalVisits.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Visits",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${_calculateAverageCost().toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Avg Cost",
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

          // Next Appointment Alert
          if (dentalVisits.any((visit) => visit["nextVisit"] != ""))
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next Appointment",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "${DateTime.parse(dentalVisits.firstWhere((visit) => visit["nextVisit"] != "")["nextVisit"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Dental Visits History
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Text(
                    "Dental Visits History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ...dentalVisits.map((visit) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getVisitTypeColor("${visit["type"]}"),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${DateTime.parse("${visit["date"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getVisitTypeColor("${visit["type"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${visit["type"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getVisitTypeColor("${visit["type"]}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Dr: ${visit["dentist"]} • ${visit["clinic"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Procedures: ${(visit["procedures"] as List).join(", ")}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "Cost: \$${(visit["cost"] as double).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (visit["rating"] as int) ? Icons.star : Icons.star_border,
                                  size: 14,
                                  color: warningColor,
                                );
                              }),
                            ),
                          ],
                        ),
                        if (visit["notes"] != "")
                          Padding(
                            padding: EdgeInsets.only(top: spXs),
                            child: Text(
                              "${visit["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
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
    );
  }

  Widget _buildRoutineTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Today's Progress
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Expanded(
                      child: Text(
                        "Today's Oral Care",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${_getCompletedRoutineCount()}/${todayRoutine.length}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: _getCompletedRoutineCount() / todayRoutine.length,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(successColor),
                ),
                SizedBox(height: spSm),
                ...todayRoutine.map((routine) {
                  bool isCompleted = routine["completed"] as bool;
                  
                  return Padding(
                    padding: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Icon(
                          isCompleted ? Icons.check_circle : Icons.circle_outlined,
                          color: isCompleted ? successColor : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${routine["activity"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: isCompleted ? successColor : primaryColor,
                              decoration: isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ),
                        Text(
                          "${routine["time"]} • ${routine["duration"]}min",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Oral Care Tips
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Oral Care Tips",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...["Brush teeth twice daily for 2 minutes", "Floss daily to remove plaque between teeth", "Use fluoride toothpaste", "Limit sugary and acidic foods", "Visit dentist every 6 months"].map((tip) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            tip,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
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
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Visit Type Distribution
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Visit Types",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...["Cleaning", "Treatment", "Checkup"].map((type) {
                  int count = dentalVisits.where((v) => v["type"] == type).length;
                  double percentage = count / dentalVisits.length;
                  Color typeColor = _getVisitTypeColor(type);
                  
                  return Padding(
                    padding: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: typeColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                type,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "$count visits",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: percentage,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(typeColor),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Cost Analysis
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cost Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(20)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$${dentalVisits.fold(0.0, (sum, v) => sum + (v["cost"] as double)).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Spent",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: successColor.withAlpha(20)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$${_calculateAverageCost().toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Average Cost",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
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

          // Dental Health Score
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dental Health Score",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "85",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Excellent Oral Health",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Keep up the good work with regular care",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddVisitTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
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
                Text(
                  "Add Dental Visit",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QDatePicker(
                  label: "Visit Date",
                  value: visitDate,
                  onChanged: (value) {
                    visitDate = value;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Visit Type",
                  items: visitTypeItems,
                  value: visitType,
                  onChanged: (value, label) {
                    visitType = value;
                    setState(() {});
                  },
                ),
                
                QTextField(
                  label: "Dentist Name",
                  value: dentistName,
                  hint: "Dr. Smith",
                  onChanged: (value) {
                    dentistName = value;
                    setState(() {});
                  },
                ),
                
                QTextField(
                  label: "Clinic Name",
                  value: clinicName,
                  hint: "SmileCare Dental",
                  onChanged: (value) {
                    clinicName = value;
                    setState(() {});
                  },
                ),
                
                QMemoField(
                  label: "Procedures",
                  value: procedures,
                  hint: "List all procedures performed",
                  onChanged: (value) {
                    procedures = value;
                    setState(() {});
                  },
                ),
                
                QNumberField(
                  label: "Cost (\$)",
                  value: visitCost.toString(),
                  onChanged: (value) {
                    visitCost = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
                
                QDatePicker(
                  label: "Next Visit Date",
                  value: nextVisitDate,
                  onChanged: (value) {
                    nextVisitDate = value;
                    setState(() {});
                  },
                ),
                
                // Rating
                Text(
                  "Rating",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        visitRating = index + 1;
                        setState(() {});
                      },
                      child: Icon(
                        index < visitRating ? Icons.star : Icons.star_border,
                        size: 32,
                        color: warningColor,
                      ),
                    );
                  }),
                ),
                
                QMemoField(
                  label: "Visit Notes",
                  value: visitNotes,
                  hint: "Any additional notes about the visit",
                  onChanged: (value) {
                    visitNotes = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add Visit",
                    size: bs.md,
                    onPressed: () {
                      // Add visit logic
                      ss("Dental visit added successfully");
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Log Daily Routine
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
                Text(
                  "Log Today's Oral Care",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Morning Brushing",
                      "value": "morning",
                      "checked": morningBrushing,
                    }
                  ],
                  value: [if (morningBrushing) {"label": "Morning Brushing", "value": "morning", "checked": true}],
                  onChanged: (values, ids) {
                    morningBrushing = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Evening Brushing",
                      "value": "evening",
                      "checked": eveningBrushing,
                    }
                  ],
                  value: [if (eveningBrushing) {"label": "Evening Brushing", "value": "evening", "checked": true}],
                  onChanged: (values, ids) {
                    eveningBrushing = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Flossing",
                      "value": "floss",
                      "checked": flossing,
                    }
                  ],
                  value: [if (flossing) {"label": "Flossing", "value": "floss", "checked": true}],
                  onChanged: (values, ids) {
                    flossing = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Mouthwash",
                      "value": "mouthwash",
                      "checked": mouthwash,
                    }
                  ],
                  value: [if (mouthwash) {"label": "Mouthwash", "value": "mouthwash", "checked": true}],
                  onChanged: (values, ids) {
                    mouthwash = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QMemoField(
                  label: "Oral Care Notes",
                  value: oralCareNotes,
                  hint: "Any observations about your oral health today",
                  onChanged: (value) {
                    oralCareNotes = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Log Routine",
                    size: bs.md,
                    onPressed: () {
                      // Log routine logic
                      ss("Oral care routine logged successfully");
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Dental Health",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Visits", icon: Icon(Icons.medical_services)),
        Tab(text: "Routine", icon: Icon(Icons.cleaning_services)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Add/Log", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildVisitsTab(),
        _buildRoutineTab(),
        _buildAnalyticsTab(),
        _buildAddVisitTab(),
      ],
    );
  }
}

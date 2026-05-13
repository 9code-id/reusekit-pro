import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaFertilityTrackerView extends StatefulWidget {
  const HcaFertilityTrackerView({super.key});

  @override
  State<HcaFertilityTrackerView> createState() => _HcaFertilityTrackerViewState();
}

class _HcaFertilityTrackerViewState extends State<HcaFertilityTrackerView> {
  int currentTab = 0;
  
  // Cycle data
  DateTime lastPeriodDate = DateTime.now().subtract(Duration(days: 15));
  String cycleLength = "28";
  String periodLength = "5";
  String selectedMood = "";
  String selectedSymptoms = "";
  String dailyNotes = "";
  
  // Mock cycle history data
  List<Map<String, dynamic>> cycleHistory = [
    {
      "month": "December 2024",
      "startDate": "2024-12-01",
      "endDate": "2024-12-05",
      "cycleLength": 28,
      "ovulationDate": "2024-12-14",
      "status": "Current",
      "fertilityWindow": ["2024-12-12", "2024-12-13", "2024-12-14", "2024-12-15", "2024-12-16"],
    },
    {
      "month": "November 2024",
      "startDate": "2024-11-03",
      "endDate": "2024-11-07",
      "cycleLength": 30,
      "ovulationDate": "2024-11-17",
      "status": "Completed",
      "fertilityWindow": ["2024-11-15", "2024-11-16", "2024-11-17", "2024-11-18", "2024-11-19"],
    },
    {
      "month": "October 2024",
      "startDate": "2024-10-04",
      "endDate": "2024-10-08",
      "cycleLength": 29,
      "ovulationDate": "2024-10-18",
      "status": "Completed",
      "fertilityWindow": ["2024-10-16", "2024-10-17", "2024-10-18", "2024-10-19", "2024-10-20"],
    },
  ];

  // Fertility predictions
  Map<String, dynamic> fertilityPrediction = {
    "nextPeriod": "2024-12-29",
    "nextOvulation": "2024-12-15",
    "fertilityWindow": ["2024-12-13", "2024-12-14", "2024-12-15", "2024-12-16", "2024-12-17"],
    "dayOfCycle": 16,
    "phase": "Ovulation",
    "pregnancyChance": "High"
  };

  // Daily tracking data
  List<Map<String, dynamic>> dailyLogs = [
    {
      "date": "2024-12-15",
      "mood": "Happy",
      "symptoms": ["Mild cramping", "Increased energy"],
      "notes": "Feeling great today, lots of energy",
      "temperature": 36.8,
      "cervicalMucus": "Clear and stretchy",
      "intimacy": true,
    },
    {
      "date": "2024-12-14",
      "mood": "Neutral",
      "symptoms": ["Bloating"],
      "notes": "Some bloating but otherwise normal",
      "temperature": 36.6,
      "cervicalMucus": "Sticky",
      "intimacy": false,
    },
    {
      "date": "2024-12-13",
      "mood": "Tired",
      "symptoms": ["Headache", "Low energy"],
      "notes": "Feeling tired, need more rest",
      "temperature": 36.5,
      "cervicalMucus": "Dry",
      "intimacy": false,
    },
  ];

  List<Map<String, dynamic>> moodItems = [
    {"label": "Happy", "value": "Happy"},
    {"label": "Sad", "value": "Sad"},
    {"label": "Anxious", "value": "Anxious"},
    {"label": "Tired", "value": "Tired"},
    {"label": "Energetic", "value": "Energetic"},
    {"label": "Neutral", "value": "Neutral"},
    {"label": "Irritated", "value": "Irritated"},
  ];

  List<Map<String, dynamic>> symptomItems = [
    {"label": "None", "value": "None"},
    {"label": "Cramping", "value": "Cramping"},
    {"label": "Bloating", "value": "Bloating"},
    {"label": "Headache", "value": "Headache"},
    {"label": "Tender breasts", "value": "Tender breasts"},
    {"label": "Nausea", "value": "Nausea"},
    {"label": "Back pain", "value": "Back pain"},
    {"label": "Acne", "value": "Acne"},
    {"label": "Increased appetite", "value": "Increased appetite"},
    {"label": "Low energy", "value": "Low energy"},
  ];

  void _logDailyData() {
    if (selectedMood.isEmpty) {
      se("Please select your mood");
      return;
    }

    setState(() {
      dailyLogs.insert(0, {
        "date": DateTime.now().toString().split(' ')[0],
        "mood": selectedMood,
        "symptoms": selectedSymptoms.split(",").map((e) => e.trim()).toList(),
        "notes": dailyNotes,
        "temperature": 36.7,
        "cervicalMucus": "Normal",
        "intimacy": false,
      });
    });

    _clearDailyForm();
    ss("Daily log added successfully");
  }

  void _clearDailyForm() {
    selectedMood = "";
    selectedSymptoms = "";
    dailyNotes = "";
    setState(() {});
  }

  void _updateCycleSettings() {
    if (cycleLength.isEmpty || periodLength.isEmpty) {
      se("Please fill in all cycle settings");
      return;
    }

    ss("Cycle settings updated successfully");
  }

  Color _getPhaseColor(String phase) {
    switch (phase.toLowerCase()) {
      case 'menstrual':
        return dangerColor;
      case 'follicular':
        return infoColor;
      case 'ovulation':
        return successColor;
      case 'luteal':
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current cycle overview
          Container(
            width: double.infinity,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Current Cycle",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Day ${fertilityPrediction["dayOfCycle"]}",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${fertilityPrediction["phase"]} Phase",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.white.withAlpha(100), width: 1),
                      ),
                      child: Text(
                        "${fertilityPrediction["pregnancyChance"]} Chance",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          
          // Quick stats
          Row(
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
                      Icon(
                        Icons.calendar_today,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Next Period",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${DateTime.parse(fertilityPrediction["nextPeriod"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.egg,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Ovulation",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${DateTime.parse(fertilityPrediction["nextOvulation"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: dangerColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Fertile Days",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(fertilityPrediction["fertilityWindow"] as List).length} days",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Fertility window
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Fertility Window",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Your most fertile days are coming up. This is the best time to try to conceive.",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (fertilityPrediction["fertilityWindow"] as List).map((date) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${DateTime.parse(date).day}/${DateTime.parse(date).month}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Recent logs
          Text(
            "Recent Daily Logs",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: dailyLogs.take(3).map((log) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(100),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "${DateTime.parse(log["date"]).day}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                            "${DateTime.parse(log["date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Mood: ${log["mood"]} • ${(log["symptoms"] as List).join(", ")}",
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyLogTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Daily Tracking",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          // Today's log form
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Log - ${DateTime.now().dMMMy}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "How are you feeling today?",
                  items: moodItems,
                  value: selectedMood,
                  onChanged: (value, label) {
                    selectedMood = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Any symptoms?",
                  items: symptomItems,
                  value: selectedSymptoms,
                  onChanged: (value, label) {
                    selectedSymptoms = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QMemoField(
                  label: "Daily Notes",
                  value: dailyNotes,
                  hint: "Any additional notes about your day...",
                  onChanged: (value) {
                    dailyNotes = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Clear",
                        color: disabledBoldColor,
                        size: bs.sm,
                        onPressed: _clearDailyForm,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Save Log",
                        size: bs.sm,
                        onPressed: _logDailyData,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // All daily logs
          Text(
            "Daily History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          if (dailyLogs.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledColor, width: 1),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.event_note,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No daily logs yet",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Start tracking your daily symptoms and mood",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: dailyLogs.map((log) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
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
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Text(
                                "${DateTime.parse(log["date"]).day}",
                                style: TextStyle(
                                  fontSize: 16,
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
                                  "${DateTime.parse(log["date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Mood: ${log["mood"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${log["temperature"]}°C",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      if ((log["symptoms"] as List).isNotEmpty) ...[
                        Text(
                          "Symptoms:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (log["symptoms"] as List).map((symptom) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$symptom",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: spSm),
                      ],
                      if (log["notes"] != null && log["notes"].toString().isNotEmpty) ...[
                        Text(
                          "Notes:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${log["notes"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildCycleHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cycle History & Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          // Cycle settings
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
                  "Cycle Settings",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Cycle Length (days)",
                        value: cycleLength,
                        hint: "Average cycle length",
                        onChanged: (value) {
                          cycleLength = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Period Length (days)",
                        value: periodLength,
                        hint: "Average period length",
                        onChanged: (value) {
                          periodLength = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QDatePicker(
                  label: "Last Period Start Date",
                  value: lastPeriodDate,
                  onChanged: (value) {
                    lastPeriodDate = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Update Settings",
                    size: bs.sm,
                    onPressed: _updateCycleSettings,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Cycle history
          Text(
            "Previous Cycles",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: cycleHistory.map((cycle) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: cycle["status"] == "Current" ? primaryColor : disabledColor,
                    width: cycle["status"] == "Current" ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${cycle["month"]}",
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
                            color: cycle["status"] == "Current" ? primaryColor : successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${cycle["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
                                "Period Duration",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${DateTime.parse(cycle["startDate"]).dMMMy} - ${DateTime.parse(cycle["endDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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
                                "Cycle Length",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${cycle["cycleLength"]} days",
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
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor, width: 1),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: successColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Ovulation: ${DateTime.parse(cycle["ovulationDate"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Fertility Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Daily Log", icon: Icon(Icons.event_note)),
        Tab(text: "Cycle History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDailyLogTab(),
        _buildCycleHistoryTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}

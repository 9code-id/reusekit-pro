import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaSymptomTrackerView extends StatefulWidget {
  const HcaSymptomTrackerView({super.key});

  @override
  State<HcaSymptomTrackerView> createState() => _HcaSymptomTrackerViewState();
}

class _HcaSymptomTrackerViewState extends State<HcaSymptomTrackerView> {
  int selectedTab = 0;
  String selectedPeriod = "week";
  bool showAddEntryForm = false;
  
  List<Map<String, dynamic>> symptomEntries = [
    {
      "id": "1",
      "date": "2024-06-19",
      "symptoms": ["Headache", "Fatigue"],
      "severity": 7,
      "duration": "4 hours",
      "triggers": ["Stress", "Lack of sleep"],
      "notes": "Woke up with mild headache that got worse during morning meeting",
      "medications": ["Ibuprofen 400mg"],
      "color": dangerColor,
    },
    {
      "id": "2",
      "date": "2024-06-18",
      "symptoms": ["Joint pain", "Stiffness"],
      "severity": 5,
      "duration": "All day",
      "triggers": ["Cold weather", "Activity"],
      "notes": "Stiffness worse in morning, improved after light exercise",
      "medications": ["Acetaminophen 500mg"],
      "color": warningColor,
    },
    {
      "id": "3",
      "date": "2024-06-17",
      "symptoms": ["Nausea", "Dizziness"],
      "severity": 6,
      "duration": "2 hours",
      "triggers": ["Medication change"],
      "notes": "Started new medication yesterday, symptoms appeared after breakfast",
      "medications": [],
      "color": warningColor,
    },
    {
      "id": "4",
      "date": "2024-06-16",
      "symptoms": ["Cough", "Sore throat"],
      "severity": 4,
      "duration": "Intermittent",
      "triggers": ["Allergies"],
      "notes": "Dry cough, worse at night. Throat feels scratchy",
      "medications": ["Honey tea", "Throat lozenges"],
      "color": infoColor,
    },
    {
      "id": "5",
      "date": "2024-06-15",
      "symptoms": ["Fatigue", "Muscle aches"],
      "severity": 8,
      "duration": "All day",
      "triggers": ["Exercise", "Dehydration"],
      "notes": "Intense workout yesterday, feeling very tired and sore",
      "medications": ["Rest", "Electrolyte drink"],
      "color": dangerColor,
    },
  ];

  // Form fields
  String newSymptomDate = DateTime.now().toIso8601String();
  List<String> newSymptoms = [];
  String newSymptomText = "";
  int newSeverity = 5;
  String newDuration = "";
  List<String> newTriggers = [];
  String newTriggerText = "";
  String newNotes = "";
  String newMedication = "";
  List<String> newMedications = [];

  List<Map<String, dynamic>> commonSymptoms = [
    {"name": "Headache", "icon": Icons.psychology},
    {"name": "Fatigue", "icon": Icons.battery_1_bar},
    {"name": "Nausea", "icon": Icons.sick},
    {"name": "Dizziness", "icon": Icons.blur_on},
    {"name": "Joint pain", "icon": Icons.accessibility},
    {"name": "Muscle aches", "icon": Icons.fitness_center},
    {"name": "Cough", "icon": Icons.air},
    {"name": "Sore throat", "icon": Icons.record_voice_over},
    {"name": "Fever", "icon": Icons.thermostat},
    {"name": "Shortness of breath", "icon": Icons.air},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Symptom Tracker",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Timeline", icon: Icon(Icons.timeline)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Patterns", icon: Icon(Icons.pattern)),
      ],
      tabChildren: [
        _buildTimelineTab(),
        _buildAnalyticsTab(),
        _buildPatternsTab(),
      ],
      withoutAppBar: false,
    );
  }

  Widget _buildTimelineTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildQuickActions(),
          _buildPeriodFilter(),
          _buildTimelineList(),
          if (showAddEntryForm) _buildAddEntryForm(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Quick Entry",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                showAddEntryForm = true;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Export Data",
              icon: Icons.download,
              size: bs.sm,
              onPressed: () {
                _exportData();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodFilter() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: QDropdownField(
        label: "View Period",
        items: [
          {"label": "This Week", "value": "week"},
          {"label": "This Month", "value": "month"},
          {"label": "Last 3 Months", "value": "3months"},
          {"label": "All Time", "value": "all"},
        ],
        value: selectedPeriod,
        onChanged: (value, label) {
          selectedPeriod = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildTimelineList() {
    List<Map<String, dynamic>> filteredEntries = _getFilteredEntries();
    
    return Column(
      spacing: spSm,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Showing ${filteredEntries.length} entries",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ...filteredEntries.map((entry) => _buildTimelineEntry(entry)),
      ],
    );
  }

  Widget _buildTimelineEntry(Map<String, dynamic> entry) {
    DateTime entryDate = DateTime.parse(entry["date"] as String);
    Color severityColor = _getSeverityColor(entry["severity"] as int);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: severityColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.event,
                color: primaryColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                entryDate.dMMMy,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: severityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Severity: ${entry["severity"]}/10",
                  style: TextStyle(
                    fontSize: 10,
                    color: severityColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (entry["symptoms"] as List<String>).map((symptom) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  symptom,
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          if ((entry["notes"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Notes:",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${entry["notes"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration: ${entry["duration"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    if ((entry["triggers"] as List).isNotEmpty)
                      Text(
                        "Triggers: ${(entry["triggers"] as List).join(", ")}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _editEntry(entry),
                child: Icon(
                  Icons.edit,
                  color: disabledBoldColor,
                  size: 16,
                ),
              ),
            ],
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
          _buildSeverityChart(),
          _buildSymptomFrequency(),
          _buildWeeklyTrends(),
        ],
      ),
    );
  }

  Widget _buildSeverityChart() {
    Map<String, int> severityDistribution = {};
    for (var entry in symptomEntries) {
      int severity = entry["severity"] as int;
      String range = severity <= 3 ? "Mild (1-3)" :
                    severity <= 6 ? "Moderate (4-6)" : "Severe (7-10)";
      severityDistribution[range] = (severityDistribution[range] ?? 0) + 1;
    }

    return Container(
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
            "Severity Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...severityDistribution.entries.map((entry) {
            int total = severityDistribution.values.reduce((a, b) => a + b);
            double percentage = (entry.value / total) * 100;
            Color barColor = entry.key.contains("Mild") ? successColor :
                           entry.key.contains("Moderate") ? warningColor : dangerColor;
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${entry.value} (${percentage.toStringAsFixed(1)}%)",
                      style: TextStyle(
                        fontSize: 12,
                        color: barColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: percentage / 100,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSymptomFrequency() {
    Map<String, int> symptomCounts = {};
    for (var entry in symptomEntries) {
      for (String symptom in entry["symptoms"] as List<String>) {
        symptomCounts[symptom] = (symptomCounts[symptom] ?? 0) + 1;
      }
    }

    var sortedSymptoms = symptomCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
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
            "Most Common Symptoms",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...sortedSymptoms.take(5).map((entry) {
            return Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${entry.value}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWeeklyTrends() {
    return Container(
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
            "Weekly Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Average severity this week: ${_calculateAverageSeverity().toStringAsFixed(1)}/10",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatternsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTriggerAnalysis(),
          _buildTimePatterns(),
          _buildMedicationEffectiveness(),
        ],
      ),
    );
  }

  Widget _buildTriggerAnalysis() {
    Map<String, int> triggerCounts = {};
    for (var entry in symptomEntries) {
      for (String trigger in entry["triggers"] as List<String>) {
        triggerCounts[trigger] = (triggerCounts[trigger] ?? 0) + 1;
      }
    }

    var sortedTriggers = triggerCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
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
            "Common Triggers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (sortedTriggers.isEmpty)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "No triggers recorded yet",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            )
          else
            ...sortedTriggers.map((entry) {
              return Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber,
                      color: warningColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "${entry.value}x",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildTimePatterns() {
    return Container(
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
            "Time Patterns",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Symptom Frequency by Day:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Most symptoms occur on weekdays (${_getMostCommonDay()})",
                  style: TextStyle(
                    fontSize: 11,
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

  Widget _buildMedicationEffectiveness() {
    return Container(
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
            "Medication Tracking",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.medication,
                  color: successColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Track medications and their effectiveness on your symptoms",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddEntryForm() {
    return Container(
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
              Text(
                "Add Symptom Entry",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showAddEntryForm = false;
                  _clearForm();
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
          QDatePicker(
            label: "Date",
            value: DateTime.parse(newSymptomDate),
            onChanged: (value) {
              newSymptomDate = value.toIso8601String();
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Add Symptom",
                  value: newSymptomText,
                  hint: "Enter symptom",
                  onChanged: (value) {
                    newSymptomText = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add",
                size: bs.sm,
                onPressed: () {
                  if (newSymptomText.isNotEmpty) {
                    newSymptoms.add(newSymptomText);
                    newSymptomText = "";
                    setState(() {});
                  }
                },
              ),
            ],
          ),
          if (commonSymptoms.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Quick Add:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: commonSymptoms.map((symptom) {
                    return GestureDetector(
                      onTap: () {
                        if (!newSymptoms.contains(symptom["name"])) {
                          newSymptoms.add(symptom["name"] as String);
                          setState(() {});
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          symptom["name"] as String,
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          if (newSymptoms.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Selected Symptoms:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: newSymptoms.map((symptom) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              symptom,
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: spXs),
                            GestureDetector(
                              onTap: () {
                                newSymptoms.remove(symptom);
                                setState(() {});
                              },
                              child: Icon(
                                Icons.close,
                                color: primaryColor,
                                size: 12,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "Severity Level: $newSeverity/10",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _getSeverityColor(newSeverity),
                ),
              ),
              Slider(
                value: newSeverity.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                activeColor: _getSeverityColor(newSeverity),
                onChanged: (value) {
                  newSeverity = value.toInt();
                  setState(() {});
                },
              ),
            ],
          ),
          QTextField(
            label: "Duration",
            value: newDuration,
            hint: "e.g., 2 hours, All day, Intermittent",
            onChanged: (value) {
              newDuration = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Notes",
            value: newNotes,
            hint: "Additional details about your symptoms",
            onChanged: (value) {
              newNotes = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () {
                    showAddEntryForm = false;
                    _clearForm();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save Entry",
                  size: bs.sm,
                  onPressed: () {
                    if (newSymptoms.isNotEmpty) {
                      _saveNewEntry();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredEntries() {
    DateTime now = DateTime.now();
    DateTime startDate;
    
    switch (selectedPeriod) {
      case "week":
        startDate = now.subtract(Duration(days: 7));
        break;
      case "month":
        startDate = now.subtract(Duration(days: 30));
        break;
      case "3months":
        startDate = now.subtract(Duration(days: 90));
        break;
      default:
        return symptomEntries;
    }
    
    return symptomEntries.where((entry) {
      DateTime entryDate = DateTime.parse(entry["date"] as String);
      return entryDate.isAfter(startDate);
    }).toList();
  }

  Color _getSeverityColor(int severity) {
    if (severity <= 3) return successColor;
    if (severity <= 6) return warningColor;
    return dangerColor;
  }

  double _calculateAverageSeverity() {
    if (symptomEntries.isEmpty) return 0.0;
    int total = symptomEntries.fold(0, (sum, entry) => sum + (entry["severity"] as int));
    return total / symptomEntries.length;
  }

  String _getMostCommonDay() {
    Map<String, int> dayCounts = {};
    for (var entry in symptomEntries) {
      DateTime date = DateTime.parse(entry["date"] as String);
      String dayName = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][date.weekday - 1];
      dayCounts[dayName] = (dayCounts[dayName] ?? 0) + 1;
    }
    
    if (dayCounts.isEmpty) return "No data";
    
    return dayCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  void _clearForm() {
    newSymptomDate = DateTime.now().toIso8601String();
    newSymptoms.clear();
    newSymptomText = "";
    newSeverity = 5;
    newDuration = "";
    newTriggers.clear();
    newTriggerText = "";
    newNotes = "";
    newMedication = "";
    newMedications.clear();
  }

  void _saveNewEntry() {
    symptomEntries.insert(0, {
      "id": "${symptomEntries.length + 1}",
      "date": newSymptomDate,
      "symptoms": List.from(newSymptoms),
      "severity": newSeverity,
      "duration": newDuration,
      "triggers": List.from(newTriggers),
      "notes": newNotes,
      "medications": List.from(newMedications),
      "color": _getSeverityColor(newSeverity),
    });

    showAddEntryForm = false;
    _clearForm();
    setState(() {});
    ss("Symptom entry saved successfully");
  }

  void _editEntry(Map<String, dynamic> entry) {
    si("Edit entry for ${DateTime.parse(entry["date"] as String).dMMMy}");
  }

  void _exportData() {
    si("Symptom data exported successfully");
  }
}

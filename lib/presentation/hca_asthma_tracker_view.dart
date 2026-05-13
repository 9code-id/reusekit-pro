import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaAsthmaTrackerView extends StatefulWidget {
  const HcaAsthmaTrackerView({super.key});

  @override
  State<HcaAsthmaTrackerView> createState() => _HcaAsthmaTrackerViewState();
}

class _HcaAsthmaTrackerViewState extends State<HcaAsthmaTrackerView> {
  int currentTab = 0;
  
  // Episode logging
  String episodeSeverity = "Mild";
  String episodeTrigger = "";
  String episodeSymptoms = "";
  String episodeLocation = "";
  String episodeDuration = "";
  String episodeNotes = "";
  
  List<Map<String, dynamic>> severityItems = [
    {"label": "Mild", "value": "Mild"},
    {"label": "Moderate", "value": "Moderate"},
    {"label": "Severe", "value": "Severe"},
    {"label": "Life-threatening", "value": "Life-threatening"},
  ];
  
  List<Map<String, dynamic>> asthmaEpisodes = [
    {
      "id": "1",
      "date": "2024-06-18",
      "time": "14:30",
      "severity": "Moderate",
      "trigger": "Dust mites",
      "symptoms": "Wheezing, shortness of breath",
      "duration": "45 minutes",
      "peakFlow": 320,
      "location": "Home",
      "medication": "Albuterol inhaler",
      "notes": "Episode triggered by cleaning bedroom",
    },
    {
      "id": "2",
      "date": "2024-06-15",
      "time": "09:15",
      "severity": "Mild",
      "trigger": "Exercise",
      "symptoms": "Mild wheezing",
      "duration": "20 minutes",
      "peakFlow": 380,
      "location": "Gym",
      "medication": "Preventive inhaler",
      "notes": "Exercise-induced asthma during cardio",
    },
    {
      "id": "3",
      "date": "2024-06-12",
      "time": "22:45",
      "severity": "Severe",
      "trigger": "Pollen",
      "symptoms": "Severe wheezing, chest tightness",
      "duration": "90 minutes",
      "peakFlow": 250,
      "location": "Outdoor",
      "medication": "Emergency inhaler + oral steroid",
      "notes": "High pollen count day, required emergency treatment",
    },
  ];
  
  List<Map<String, dynamic>> asthmamedications = [
    {
      "id": "1",
      "name": "Albuterol Inhaler",
      "type": "Rescue",
      "dosage": "2 puffs",
      "frequency": "As needed",
      "lastTaken": "2024-06-18 14:30",
      "remaining": 85,
      "expiry": "2024-12-15",
      "sideEffects": "Mild tremor",
    },
    {
      "id": "2",
      "name": "Fluticasone Propionate",
      "type": "Controller",
      "dosage": "2 puffs",
      "frequency": "Twice daily",
      "lastTaken": "2024-06-18 08:00",
      "remaining": 120,
      "expiry": "2025-03-20",
      "sideEffects": "Oral thrush (rare)",
    },
    {
      "id": "3",
      "name": "Montelukast",
      "type": "Controller",
      "dosage": "10mg",
      "frequency": "Once daily",
      "lastTaken": "2024-06-18 20:00",
      "remaining": 28,
      "expiry": "2024-08-30",
      "sideEffects": "None reported",
    },
  ];

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Mild":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Severe":
        return dangerColor;
      case "Life-threatening":
        return Colors.red.shade900;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildEpisodesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Stats
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
                        "This Week",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "2",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Episodes",
                        style: TextStyle(
                          fontSize: 10,
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
                        "Avg Peak Flow",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "350",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "L/min",
                        style: TextStyle(
                          fontSize: 10,
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
                        "Control Level",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Moderate",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Recent Episodes
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
                  child: Row(
                    children: [
                      Text(
                        "Recent Episodes",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          setState(() {
                            currentTab = 3;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ...asthmaEpisodes.map((episode) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getSeverityColor("${episode["severity"]}"),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${episode["date"]} ${episode["time"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getSeverityColor("${episode["severity"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${episode["severity"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getSeverityColor("${episode["severity"]}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Trigger: ${episode["trigger"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Duration: ${episode["duration"]} | Peak Flow: ${episode["peakFlow"]} L/min",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (episode["notes"] != null && "${episode["notes"]}".isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: spXs),
                            child: Text(
                              "${episode["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Medication Adherence
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
                  "Today's Adherence",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "85%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Adherence Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "2/3",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Doses Taken",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "1",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
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
                  ],
                ),
              ],
            ),
          ),

          // Medications List
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
                    "Current Medications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...asthmamedications.map((medication) {
                  Color typeColor = "${medication["type"]}" == "Rescue" ? dangerColor : infoColor;
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: typeColor,
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
                                "${medication["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: typeColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${medication["type"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: typeColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Dosage: ${medication["dosage"]} | Frequency: ${medication["frequency"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Remaining: ${medication["remaining"]} doses | Expires: ${medication["expiry"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if ("${medication["sideEffects"]}".isNotEmpty)
                          Text(
                            "Side effects: ${medication["sideEffects"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
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
          // Control Assessment
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
                  "Asthma Control Assessment",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Your asthma control is PARTIALLY CONTROLLED. Consider adjusting your treatment plan.",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Trends
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
                  "Monthly Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
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
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Episodes",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "↓ 15%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "vs last month",
                              style: TextStyle(
                                fontSize: 10,
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
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Peak Flow",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "↑ 8%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "vs last month",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
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

          // Trigger Analysis
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
                  "Common Triggers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Dust mites",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.45,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "45%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Exercise",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.30,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "30%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Pollen",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.25,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: infoColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "25%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogEpisodeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
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
              children: [
                Text(
                  "Log New Episode",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spSm,
                  children: [
                    QDropdownField(
                      label: "Episode Severity",
                      items: severityItems,
                      value: episodeSeverity,
                      onChanged: (value, label) {
                        episodeSeverity = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Primary Trigger",
                      value: episodeTrigger,
                      hint: "e.g., dust, pollen, exercise",
                      onChanged: (value) {
                        episodeTrigger = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Symptoms Experienced",
                      value: episodeSymptoms,
                      hint: "Describe symptoms in detail",
                      onChanged: (value) {
                        episodeSymptoms = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Location",
                            value: episodeLocation,
                            hint: "Where did it occur?",
                            onChanged: (value) {
                              episodeLocation = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Duration",
                            value: episodeDuration,
                            hint: "e.g., 30 minutes",
                            onChanged: (value) {
                              episodeDuration = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QMemoField(
                      label: "Additional Notes",
                      value: episodeNotes,
                      hint: "Any additional observations or treatment taken",
                      onChanged: (value) {
                        episodeNotes = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Episode",
              size: bs.md,
              onPressed: () {
                // Save episode logic
                ss("Episode logged successfully");
                // Reset form
                episodeSeverity = "Mild";
                episodeTrigger = "";
                episodeSymptoms = "";
                episodeLocation = "";
                episodeDuration = "";
                episodeNotes = "";
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Asthma Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Episodes", icon: Icon(Icons.timeline)),
        Tab(text: "Medications", icon: Icon(Icons.medication)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Log Episode", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        _buildEpisodesTab(),
        _buildMedicationsTab(),
        _buildAnalyticsTab(),
        _buildLogEpisodeTab(),
      ],
    );
  }
}

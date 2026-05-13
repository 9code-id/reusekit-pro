import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaRespiratoryHealthView extends StatefulWidget {
  const HcaRespiratoryHealthView({super.key});

  @override
  State<HcaRespiratoryHealthView> createState() => _HcaRespiratoryHealthViewState();
}

class _HcaRespiratoryHealthViewState extends State<HcaRespiratoryHealthView> {
  int currentTab = 0;
  String selectedCategory = "All";
  String selectedPeriod = "Week";
  
  List<Map<String, dynamic>> respiratoryReadings = [
    {
      "id": 1,
      "type": "Peak Flow",
      "value": 450,
      "unit": "L/min",
      "timestamp": "2024-01-15 08:30",
      "status": "Normal",
      "color": successColor,
      "icon": Icons.air,
    },
    {
      "id": 2,
      "type": "SpO2",
      "value": 98,
      "unit": "%",
      "timestamp": "2024-01-15 08:25",
      "status": "Normal",
      "color": successColor,
      "icon": Icons.monitor_heart,
    },
    {
      "id": 3,
      "type": "Respiratory Rate",
      "value": 16,
      "unit": "breaths/min",
      "timestamp": "2024-01-15 08:20",
      "status": "Normal",
      "color": successColor,
      "icon": Icons.waves,
    },
    {
      "id": 4,
      "type": "Peak Flow",
      "value": 380,
      "unit": "L/min",
      "timestamp": "2024-01-14 19:45",
      "status": "Low",
      "color": warningColor,
      "icon": Icons.air,
    },
    {
      "id": 5,
      "type": "SpO2",
      "value": 95,
      "unit": "%",
      "timestamp": "2024-01-14 12:30",
      "status": "Low",
      "color": warningColor,
      "icon": Icons.monitor_heart,
    },
  ];

  List<Map<String, dynamic>> medications = [
    {
      "id": 1,
      "name": "Albuterol Inhaler",
      "dosage": "2 puffs",
      "frequency": "As needed",
      "nextDose": "2024-01-15 16:00",
      "type": "Rescue",
      "color": dangerColor,
      "taken": false,
    },
    {
      "id": 2,
      "name": "Fluticasone",
      "dosage": "50 mcg",
      "frequency": "Twice daily",
      "nextDose": "2024-01-15 20:00",
      "type": "Controller",
      "color": primaryColor,
      "taken": true,
    },
    {
      "id": 3,
      "name": "Montelukast",
      "dosage": "10 mg",
      "frequency": "Once daily",
      "nextDose": "2024-01-16 08:00",
      "type": "Preventive",
      "color": successColor,
      "taken": false,
    },
  ];

  List<Map<String, dynamic>> triggers = [
    {
      "id": 1,
      "name": "Dust Mites",
      "severity": "High",
      "color": dangerColor,
      "lastExposure": "2024-01-12",
      "notes": "Bedroom carpet needs cleaning",
    },
    {
      "id": 2,
      "name": "Pollen",
      "severity": "Medium",
      "color": warningColor,
      "lastExposure": "2024-01-10",
      "notes": "Spring season approaching",
    },
    {
      "id": 3,
      "name": "Exercise",
      "severity": "Low",
      "color": infoColor,
      "lastExposure": "2024-01-14",
      "notes": "Use rescue inhaler before activity",
    },
    {
      "id": 4,
      "name": "Cold Air",
      "severity": "Medium",
      "color": warningColor,
      "lastExposure": "2024-01-13",
      "notes": "Use scarf to warm air",
    },
  ];

  List<Map<String, dynamic>> symptoms = [
    {
      "id": 1,
      "symptom": "Shortness of breath",
      "severity": 3,
      "timestamp": "2024-01-15 14:30",
      "trigger": "Exercise",
      "duration": "15 minutes",
      "relief": "Rescue inhaler used",
    },
    {
      "id": 2,
      "symptom": "Wheezing",
      "severity": 2,
      "timestamp": "2024-01-14 22:15",
      "trigger": "Dust exposure",
      "duration": "30 minutes",
      "relief": "Improved with medication",
    },
    {
      "id": 3,
      "symptom": "Chest tightness",
      "severity": 4,
      "timestamp": "2024-01-13 16:45",
      "trigger": "Cold air",
      "duration": "45 minutes",
      "relief": "Rest and warm environment",
    },
  ];

  List<Map<String, dynamic>> exercises = [
    {
      "id": 1,
      "name": "Breathing Exercises",
      "duration": "10 minutes",
      "completed": true,
      "lastDone": "2024-01-15 08:00",
      "description": "Diaphragmatic breathing and pursed lip breathing",
      "benefits": "Improves lung function and reduces anxiety",
    },
    {
      "id": 2,
      "name": "Walking",
      "duration": "20 minutes",
      "completed": false,
      "lastDone": "2024-01-14 17:30",
      "description": "Moderate pace outdoor walk",
      "benefits": "Builds cardiovascular endurance",
    },
    {
      "id": 3,
      "name": "Chest Stretches",
      "duration": "15 minutes",
      "completed": true,
      "lastDone": "2024-01-15 07:45",
      "description": "Upper body stretching routine",
      "benefits": "Improves chest expansion and posture",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Respiratory Health",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Vitals", icon: Icon(Icons.monitor_heart)),
        Tab(text: "Medications", icon: Icon(Icons.medication)),
        Tab(text: "Triggers", icon: Icon(Icons.warning)),
        Tab(text: "Symptoms", icon: Icon(Icons.sick)),
        Tab(text: "Exercises", icon: Icon(Icons.self_improvement)),
      ],
      tabChildren: [
        _buildVitalsTab(),
        _buildMedicationsTab(),
        _buildTriggersTab(),
        _buildSymptomsTab(),
        _buildExercisesTab(),
      ],
    );
  }

  Widget _buildVitalsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildQuickStatCard(
                  "Peak Flow",
                  "450 L/min",
                  "Normal range",
                  successColor,
                  Icons.air,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard(
                  "SpO2",
                  "98%",
                  "Excellent",
                  successColor,
                  Icons.monitor_heart,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildQuickStatCard(
                  "Resp. Rate",
                  "16 bpm",
                  "Normal",
                  successColor,
                  Icons.waves,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard(
                  "Last Reading",
                  "30 min ago",
                  "Recent",
                  infoColor,
                  Icons.schedule,
                ),
              ),
            ],
          ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Readings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QButton(
                      label: "Add Reading",
                      size: bs.sm,
                      onPressed: () => _showAddReadingDialog(),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...respiratoryReadings.map((reading) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (reading["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: reading["color"] as Color,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        reading["icon"] as IconData,
                        color: reading["color"] as Color,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${reading["type"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${reading["value"]} ${reading["unit"]} • ${reading["status"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${reading["timestamp"]}".split(' ')[1],
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
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
          Row(
            children: [
              Expanded(
                child: _buildQuickStatCard(
                  "Active Meds",
                  "${medications.length}",
                  "Total medications",
                  primaryColor,
                  Icons.medication,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard(
                  "Next Dose",
                  "4:00 PM",
                  "Albuterol",
                  warningColor,
                  Icons.schedule,
                ),
              ),
            ],
          ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Current Medications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QButton(
                      label: "Add Medication",
                      size: bs.sm,
                      onPressed: () => _showAddMedicationDialog(),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...medications.map((medication) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 40,
                        decoration: BoxDecoration(
                          color: medication["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusSm),
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
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${medication["dosage"]} • ${medication["frequency"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Type: ${medication["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: medication["color"] as Color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Icon(
                            medication["taken"] as bool ? Icons.check_circle : Icons.schedule,
                            color: medication["taken"] as bool ? successColor : warningColor,
                            size: 20,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            medication["taken"] as bool ? "Taken" : "Pending",
                            style: TextStyle(
                              fontSize: 10,
                              color: medication["taken"] as bool ? successColor : warningColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTriggersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildQuickStatCard(
                  "High Risk",
                  "1",
                  "Active triggers",
                  dangerColor,
                  Icons.warning,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard(
                  "Medium Risk",
                  "2",
                  "Monitor closely",
                  warningColor,
                  Icons.visibility,
                ),
              ),
            ],
          ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Known Triggers",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QButton(
                      label: "Add Trigger",
                      size: bs.sm,
                      onPressed: () => _showAddTriggerDialog(),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 300,
                  children: triggers.map((trigger) => Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (trigger["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: trigger["color"] as Color,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${trigger["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: trigger["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "${trigger["severity"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Last exposure: ${trigger["lastExposure"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${trigger["notes"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildQuickStatCard(
                  "Today",
                  "1",
                  "Symptom episodes",
                  warningColor,
                  Icons.sick,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard(
                  "This Week",
                  "3",
                  "Total episodes",
                  infoColor,
                  Icons.calendar_month,
                ),
              ),
            ],
          ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Symptom Log",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QButton(
                      label: "Log Symptom",
                      size: bs.sm,
                      onPressed: () => _showLogSymptomDialog(),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...symptoms.map((symptom) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${symptom["symptom"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) => Icon(
                              Icons.circle,
                              size: 8,
                              color: index < (symptom["severity"] as int) ? dangerColor : disabledColor,
                            )),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Trigger: ${symptom["trigger"]} • Duration: ${symptom["duration"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Relief: ${symptom["relief"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${symptom["timestamp"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildQuickStatCard(
                  "Completed",
                  "2",
                  "Today's exercises",
                  successColor,
                  Icons.check_circle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard(
                  "Remaining",
                  "1",
                  "Pending exercises",
                  warningColor,
                  Icons.pending,
                ),
              ),
            ],
          ),
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
                  "Respiratory Exercises",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...exercises.map((exercise) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (exercise["completed"] as bool) ? successColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: (exercise["completed"] as bool) ? successColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${exercise["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Icon(
                            (exercise["completed"] as bool) ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: (exercise["completed"] as bool) ? successColor : disabledBoldColor,
                            size: 20,
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Duration: ${exercise["duration"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${exercise["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Benefits: ${exercise["benefits"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      if (exercise["completed"] as bool) ...[
                        SizedBox(height: spXs),
                        Text(
                          "Last done: ${exercise["lastDone"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddReadingDialog() {
    // Add reading dialog implementation
  }

  void _showAddMedicationDialog() {
    // Add medication dialog implementation
  }

  void _showAddTriggerDialog() {
    // Add trigger dialog implementation
  }

  void _showLogSymptomDialog() {
    // Log symptom dialog implementation
  }
}

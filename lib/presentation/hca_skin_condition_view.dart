import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaSkinConditionView extends StatefulWidget {
  const HcaSkinConditionView({super.key});

  @override
  State<HcaSkinConditionView> createState() => _HcaSkinConditionViewState();
}

class _HcaSkinConditionViewState extends State<HcaSkinConditionView> {
  int currentTab = 0;
  
  // Log Form Variables
  String conditionType = "";
  String severity = "";
  String location = "";
  String symptoms = "";
  String triggers = "";
  String treatment = "";
  String notes = "";
  
  List<Map<String, dynamic>> conditionTypeItems = [
    {"label": "Eczema", "value": "Eczema"},
    {"label": "Psoriasis", "value": "Psoriasis"},
    {"label": "Acne", "value": "Acne"},
    {"label": "Rosacea", "value": "Rosacea"},
    {"label": "Dermatitis", "value": "Dermatitis"},
    {"label": "Hives", "value": "Hives"},
    {"label": "Other", "value": "Other"},
  ];
  
  List<Map<String, dynamic>> severityItems = [
    {"label": "Mild", "value": "Mild"},
    {"label": "Moderate", "value": "Moderate"},
    {"label": "Severe", "value": "Severe"},
    {"label": "Very Severe", "value": "Very Severe"},
  ];
  
  List<Map<String, dynamic>> conditionLogs = [
    {
      "id": "1",
      "date": "2024-06-18",
      "time": "09:30",
      "type": "Eczema",
      "severity": "Moderate",
      "location": "Arms, Face",
      "symptoms": "Itching, Redness, Dry patches",
      "triggers": "Stress, Cold weather",
      "treatment": "Moisturizer, Hydrocortisone cream",
      "notes": "Flare-up after work stress",
      "photos": 2,
    },
    {
      "id": "2",
      "date": "2024-06-15",
      "time": "14:20",
      "type": "Acne",
      "severity": "Mild",
      "location": "Face (T-zone)",
      "symptoms": "Small bumps, Blackheads",
      "triggers": "Hormonal changes",
      "treatment": "Salicylic acid cleanser",
      "notes": "Monthly breakout pattern",
      "photos": 1,
    },
    {
      "id": "3",
      "date": "2024-06-12",
      "time": "16:45",
      "type": "Psoriasis",
      "severity": "Severe",
      "location": "Elbows, Knees",
      "symptoms": "Thick scales, Bleeding",
      "triggers": "Weather change",
      "treatment": "Topical steroid, Light therapy",
      "notes": "Scheduled dermatologist visit",
      "photos": 3,
    },
  ];
  
  List<Map<String, dynamic>> treatments = [
    {
      "id": "1",
      "name": "Hydrocortisone Cream 1%",
      "type": "Topical Steroid",
      "condition": "Eczema",
      "dosage": "Apply twice daily",
      "effectiveness": 85,
      "sideEffects": "None reported",
      "cost": 15.99,
      "lastUsed": "2024-06-18",
    },
    {
      "id": "2", 
      "name": "Salicylic Acid Cleanser",
      "type": "Topical Treatment",
      "condition": "Acne",
      "dosage": "Use daily",
      "effectiveness": 70,
      "sideEffects": "Mild dryness",
      "cost": 12.50,
      "lastUsed": "2024-06-17",
    },
    {
      "id": "3",
      "name": "Clobetasol Propionate",
      "type": "Prescription Steroid",
      "condition": "Psoriasis",
      "dosage": "Apply once daily",
      "effectiveness": 90,
      "sideEffects": "Skin thinning",
      "cost": 45.00,
      "lastUsed": "2024-06-16",
    },
  ];

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Mild":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Severe":
        return Colors.orange;
      case "Very Severe":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Skin Condition Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Conditions", icon: Icon(Icons.healing)),
        Tab(text: "Treatments", icon: Icon(Icons.medical_services)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Log Entry", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        _buildConditionsTab(),
        _buildTreatmentsTab(),
        _buildAnalyticsTab(),
        _buildLogEntryTab(),
      ],
    );
  }

  Widget _buildConditionsTab() {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Logs",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${conditionLogs.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Active Conditions",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "3",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Recent Condition Logs
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
                  "Recent Condition Logs",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...conditionLogs.map((log) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${log["type"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getSeverityColor(log["severity"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${log["severity"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getSeverityColor(log["severity"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Location: ${log["location"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Symptoms: ${log["symptoms"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        if ((log["notes"] as String).isNotEmpty) ...[
                          SizedBox(height: spXs),
                          Text(
                            "Notes: ${log["notes"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${log["date"]} ${log["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            if ((log["photos"] as int) > 0) ...[
                              Icon(
                                Icons.photo_camera,
                                size: 16,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${log["photos"]} photos",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ],
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

  Widget _buildTreatmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Treatment Overview
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
                  "Treatment Overview",
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
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Active Treatments",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${treatments.length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
                              "Avg Effectiveness",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${((treatments.map((t) => t["effectiveness"] as int).reduce((a, b) => a + b)) / treatments.length).round()}%",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
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

          // Treatments List
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
                  "Current Treatments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...treatments.map((treatment) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
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
                                    "${treatment["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${treatment["type"]} • ${treatment["condition"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${treatment["effectiveness"]}%",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: (treatment["effectiveness"] as int) >= 80 
                                        ? successColor 
                                        : (treatment["effectiveness"] as int) >= 60 
                                        ? warningColor 
                                        : dangerColor,
                                  ),
                                ),
                                Text(
                                  "Effectiveness",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          spacing: spMd,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dosage",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${treatment["dosage"]}",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                    "Cost",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(treatment["cost"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if ((treatment["sideEffects"] as String).isNotEmpty) ...[
                          SizedBox(height: spSm),
                          Text(
                            "Side Effects: ${treatment["sideEffects"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: warningColor,
                            ),
                          ),
                        ],
                        SizedBox(height: spSm),
                        Text(
                          "Last used: ${treatment["lastUsed"]}",
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
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    Map<String, int> conditionFrequency = {};
    Map<String, int> severityDistribution = {};
    
    for (var log in conditionLogs) {
      String condition = log["type"];
      String severity = log["severity"];
      
      conditionFrequency[condition] = (conditionFrequency[condition] ?? 0) + 1;
      severityDistribution[severity] = (severityDistribution[severity] ?? 0) + 1;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Condition Frequency Chart
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
                  "Condition Frequency",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...conditionFrequency.entries.map((entry) {
                  double percentage = (entry.value / conditionLogs.length) * 100;
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "${entry.value} (${percentage.toStringAsFixed(1)}%)",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: percentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
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

          // Severity Distribution
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
                  "Severity Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: severityDistribution.entries.map((entry) {
                    return Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getSeverityColor(entry.key).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${entry.value}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _getSeverityColor(entry.key),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              entry.key,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Treatment Effectiveness
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
                  "Treatment Effectiveness",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...treatments.map((treatment) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${treatment["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (treatment["effectiveness"] as int) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (treatment["effectiveness"] as int) >= 80 
                                      ? successColor 
                                      : (treatment["effectiveness"] as int) >= 60 
                                      ? warningColor 
                                      : dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${treatment["effectiveness"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: (treatment["effectiveness"] as int) >= 80 
                                ? successColor 
                                : (treatment["effectiveness"] as int) >= 60 
                                ? warningColor 
                                : dangerColor,
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

  Widget _buildLogEntryTab() {
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
                  "Log Skin Condition",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                // Condition Type
                QDropdownField(
                  label: "Condition Type",
                  items: conditionTypeItems,
                  value: conditionType,
                  onChanged: (value, label) {
                    conditionType = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Severity
                QDropdownField(
                  label: "Severity Level",
                  items: severityItems,
                  value: severity,
                  onChanged: (value, label) {
                    severity = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Location
                QTextField(
                  label: "Affected Location",
                  value: location,
                  hint: "e.g., Face, Arms, Legs",
                  onChanged: (value) {
                    location = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Symptoms
                QMemoField(
                  label: "Symptoms",
                  value: symptoms,
                  hint: "Describe symptoms (itching, redness, pain, etc.)",
                  onChanged: (value) {
                    symptoms = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Triggers
                QMemoField(
                  label: "Possible Triggers",
                  value: triggers,
                  hint: "What might have caused this flare-up?",
                  onChanged: (value) {
                    triggers = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Treatment Applied
                QMemoField(
                  label: "Treatment Applied",
                  value: treatment,
                  hint: "Medications, creams, or treatments used",
                  onChanged: (value) {
                    treatment = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Notes
                QMemoField(
                  label: "Additional Notes",
                  value: notes,
                  hint: "Any other relevant information",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spMd),
                
                // Save Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Save Condition Log",
                    size: bs.md,
                    onPressed: () {
                      // Save condition log logic
                      ss("Condition log saved successfully");
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
}

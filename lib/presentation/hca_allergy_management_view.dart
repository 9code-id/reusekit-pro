import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaAllergyManagementView extends StatefulWidget {
  const HcaAllergyManagementView({super.key});

  @override
  State<HcaAllergyManagementView> createState() => _HcaAllergyManagementViewState();
}

class _HcaAllergyManagementViewState extends State<HcaAllergyManagementView> {
  int currentTab = 0;

  // Allergy List Data
  List<Map<String, dynamic>> allergies = [
    {
      "id": "1",
      "allergen": "Peanuts",
      "type": "Food",
      "severity": "Severe",
      "symptoms": ["Anaphylaxis", "Hives", "Swelling"],
      "firstReaction": "2019-03-15",
      "lastReaction": "2024-05-20",
      "notes": "Carries EpiPen at all times",
      "medicationRequired": true,
    },
    {
      "id": "2",
      "allergen": "Dust Mites",
      "type": "Environmental",
      "severity": "Moderate",
      "symptoms": ["Sneezing", "Runny nose", "Itchy eyes"],
      "firstReaction": "2020-08-10",
      "lastReaction": "2024-06-15",
      "notes": "Worse during spring season",
      "medicationRequired": false,
    },
    {
      "id": "3",
      "allergen": "Penicillin",
      "type": "Medication",
      "severity": "Severe",
      "symptoms": ["Skin rash", "Fever", "Difficulty breathing"],
      "firstReaction": "2018-12-05",
      "lastReaction": "2018-12-05",
      "notes": "Medical alert bracelet worn",
      "medicationRequired": false,
    },
    {
      "id": "4",
      "allergen": "Cat Dander",
      "type": "Animal",
      "severity": "Mild",
      "symptoms": ["Sneezing", "Watery eyes"],
      "firstReaction": "2021-04-22",
      "lastReaction": "2024-06-10",
      "notes": "Symptoms manageable with antihistamines",
      "medicationRequired": true,
    },
  ];

  // Emergency Medications Data
  List<Map<String, dynamic>> emergencyMeds = [
    {
      "id": "1",
      "medication": "EpiPen (Epinephrine)",
      "allergen": "Peanuts",
      "dosage": "0.3mg",
      "expiryDate": "2025-03-15",
      "location": "Purse",
      "instructions": "Inject into thigh muscle immediately",
      "expired": false,
    },
    {
      "id": "2",
      "medication": "Benadryl",
      "allergen": "Cat Dander",
      "dosage": "25mg",
      "expiryDate": "2025-08-20",
      "location": "Medicine Cabinet",
      "instructions": "Take 1-2 tablets for mild reactions",
      "expired": false,
    },
  ];

  // Form fields for logging reactions
  String selectedAllergen = "";
  String reactionSeverity = "";
  String symptoms = "";
  String treatment = "";
  DateTime reactionDate = DateTime.now();
  String reactionTime = "12:00";
  String notes = "";

  // Form fields for new allergy
  String newAllergen = "";
  String allergyType = "";
  String severityLevel = "";
  String knownSymptoms = "";
  DateTime firstReactionDate = DateTime.now();
  String allergyNotes = "";

  List<Map<String, dynamic>> allergenItems = [
    {"label": "Select Allergen", "value": ""},
    {"label": "Peanuts", "value": "Peanuts"},
    {"label": "Tree Nuts", "value": "Tree Nuts"},
    {"label": "Shellfish", "value": "Shellfish"},
    {"label": "Eggs", "value": "Eggs"},
    {"label": "Milk", "value": "Milk"},
    {"label": "Soy", "value": "Soy"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Dust Mites", "value": "Dust Mites"},
    {"label": "Pollen", "value": "Pollen"},
    {"label": "Pet Dander", "value": "Pet Dander"},
    {"label": "Penicillin", "value": "Penicillin"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> severityItems = [
    {"label": "Select Severity", "value": ""},
    {"label": "Mild", "value": "Mild"},
    {"label": "Moderate", "value": "Moderate"},
    {"label": "Severe", "value": "Severe"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "Select Type", "value": ""},
    {"label": "Food", "value": "Food"},
    {"label": "Environmental", "value": "Environmental"},
    {"label": "Medication", "value": "Medication"},
    {"label": "Animal", "value": "Animal"},
    {"label": "Chemical", "value": "Chemical"},
    {"label": "Other", "value": "Other"},
  ];

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case "mild":
        return successColor;
      case "moderate":
        return warningColor;
      case "severe":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildAllergiesTab() {
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
                        "${allergies.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Known Allergies",
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
                        "${allergies.where((a) => a["severity"] == "Severe").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Severe Allergies",
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

          // Allergies List
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
                    "All Allergies",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ...allergies.map((allergy) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getSeverityColor("${allergy["severity"]}"),
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
                                "${allergy["allergen"]}",
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
                                color: _getSeverityColor("${allergy["severity"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${allergy["severity"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getSeverityColor("${allergy["severity"]}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Type: ${allergy["type"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Symptoms: ${(allergy["symptoms"] as List).join(", ")}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (allergy["notes"] != "")
                          Padding(
                            padding: EdgeInsets.only(top: spXs),
                            child: Text(
                              "Notes: ${allergy["notes"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "Last Reaction: ${DateTime.parse("${allergy["lastReaction"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            if (allergy["medicationRequired"] == true)
                              Icon(
                                Icons.medical_services,
                                size: 16,
                                color: warningColor,
                              ),
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

  Widget _buildMedicationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Emergency Alert
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: dangerColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Emergency medications should be checked regularly for expiration",
                    style: TextStyle(
                      fontSize: 14,
                      color: dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Emergency Medications
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
                    "Emergency Medications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ...emergencyMeds.map((med) {
                  bool isExpiringSoon = DateTime.parse("${med["expiryDate"]}").difference(DateTime.now()).inDays < 90;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: isExpiringSoon ? warningColor : successColor,
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
                                "${med["medication"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            if (isExpiringSoon)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Expiring Soon",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "For: ${med["allergen"]} • Dosage: ${med["dosage"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Location: ${med["location"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${med["instructions"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "Expires: ${DateTime.parse("${med["expiryDate"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isExpiringSoon ? warningColor : disabledBoldColor,
                                fontWeight: isExpiringSoon ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.medical_services,
                              size: 16,
                              color: primaryColor,
                            ),
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Analytics Cards
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
                        "3",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Reactions This Year",
                        textAlign: TextAlign.center,
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
                        "89%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Avoidance Success",
                        textAlign: TextAlign.center,
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

          // Allergy Breakdown by Type
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
                  "Allergies by Type",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...["Food", "Environmental", "Medication", "Animal"].map((type) {
                  int count = allergies.where((a) => a["type"] == type).length;
                  double percentage = count / allergies.length;
                  
                  return Padding(
                    padding: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
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
                              "$count",
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
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
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
                SizedBox(height: spSm),
                ...["Severe", "Moderate", "Mild"].map((severity) {
                  int count = allergies.where((a) => a["severity"] == severity).length;
                  Color severityColor = _getSeverityColor(severity);
                  
                  return Padding(
                    padding: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: severityColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            severity,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "$count allergies",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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

  Widget _buildAddAllergyTab() {
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
                  "Add New Allergy",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QTextField(
                  label: "Allergen Name",
                  value: newAllergen,
                  hint: "e.g., Peanuts, Shellfish, Penicillin",
                  onChanged: (value) {
                    newAllergen = value;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Allergy Type",
                  items: typeItems,
                  value: allergyType,
                  onChanged: (value, label) {
                    allergyType = value;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Severity Level",
                  items: severityItems,
                  value: severityLevel,
                  onChanged: (value, label) {
                    severityLevel = value;
                    setState(() {});
                  },
                ),
                
                QMemoField(
                  label: "Known Symptoms",
                  value: knownSymptoms,
                  hint: "List the symptoms you experience",
                  onChanged: (value) {
                    knownSymptoms = value;
                    setState(() {});
                  },
                ),
                
                QDatePicker(
                  label: "First Reaction Date",
                  value: firstReactionDate,
                  onChanged: (value) {
                    firstReactionDate = value;
                    setState(() {});
                  },
                ),
                
                QMemoField(
                  label: "Additional Notes",
                  value: allergyNotes,
                  hint: "Any additional information about this allergy",
                  onChanged: (value) {
                    allergyNotes = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add Allergy",
                    size: bs.md,
                    onPressed: () {
                      // Add allergy logic
                      ss("Allergy added successfully");
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Log Reaction Section
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
                  "Log Allergic Reaction",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QDropdownField(
                  label: "Allergen",
                  items: allergenItems,
                  value: selectedAllergen,
                  onChanged: (value, label) {
                    selectedAllergen = value;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Reaction Severity",
                  items: severityItems,
                  value: reactionSeverity,
                  onChanged: (value, label) {
                    reactionSeverity = value;
                    setState(() {});
                  },
                ),
                
                QMemoField(
                  label: "Symptoms Experienced",
                  value: symptoms,
                  hint: "Describe the symptoms you experienced",
                  onChanged: (value) {
                    symptoms = value;
                    setState(() {});
                  },
                ),
                
                QMemoField(
                  label: "Treatment Given",
                  value: treatment,
                  hint: "What medication or treatment was used",
                  onChanged: (value) {
                    treatment = value;
                    setState(() {});
                  },
                ),
                
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Reaction Date",
                        value: reactionDate,
                        onChanged: (value) {
                          reactionDate = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QTimePicker(
                        label: "Time",
                        value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $reactionTime")),
                        onChanged: (value) {
                          reactionTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                QMemoField(
                  label: "Additional Notes",
                  value: notes,
                  hint: "Any additional details about the reaction",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Log Reaction",
                    size: bs.md,
                    onPressed: () {
                      // Log reaction logic
                      ss("Reaction logged successfully");
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
      title: "Allergy Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Allergies", icon: Icon(Icons.warning)),
        Tab(text: "Medications", icon: Icon(Icons.medical_services)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Add/Log", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildAllergiesTab(),
        _buildMedicationsTab(),
        _buildAnalyticsTab(),
        _buildAddAllergyTab(),
      ],
    );
  }
}

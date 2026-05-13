import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaAllergyTrackerView extends StatefulWidget {
  const MhaAllergyTrackerView({super.key});

  @override
  State<MhaAllergyTrackerView> createState() => _MhaAllergyTrackerViewState();
}

class _MhaAllergyTrackerViewState extends State<MhaAllergyTrackerView> {
  final formKey = GlobalKey<FormState>();
  
  // Filter states
  String selectedSeverity = "All Severities";
  String selectedType = "All Types";
  String searchQuery = "";
  bool showActiveOnly = false;
  
  // Form states for adding allergy
  String allergyName = "";
  String allergyDescription = "";
  String selectedAllergyType = "Food";
  String selectedSeverityLevel = "Mild";
  String symptoms = "";
  String triggers = "";
  String treatment = "";
  String notes = "";
  String diagnosedDate = DateTime.now().toString().split(' ')[0];
  bool isActive = true;
  
  List<Map<String, dynamic>> severityOptions = [
    {"label": "All Severities", "value": "All Severities"},
    {"label": "Mild", "value": "Mild"},
    {"label": "Moderate", "value": "Moderate"},
    {"label": "Severe", "value": "Severe"},
    {"label": "Life-threatening", "value": "Life-threatening"},
  ];
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Food", "value": "Food"},
    {"label": "Environmental", "value": "Environmental"},
    {"label": "Medication", "value": "Medication"},
    {"label": "Insect", "value": "Insect"},
    {"label": "Contact", "value": "Contact"},
    {"label": "Other", "value": "Other"},
  ];
  
  List<Map<String, dynamic>> allergies = [
    {
      "id": "1",
      "name": "Peanuts",
      "description": "Severe peanut allergy",
      "type": "Food",
      "severity": "Severe",
      "symptoms": [
        "Hives",
        "Swelling of face and lips",
        "Difficulty breathing",
        "Nausea and vomiting"
      ],
      "triggers": ["Peanuts", "Peanut oil", "Cross-contaminated foods"],
      "treatment": "EpiPen auto-injector, Benadryl, Emergency room",
      "diagnosedDate": "2020-03-15",
      "lastReaction": "2023-11-22",
      "reactionSeverity": "Severe",
      "notes": "Always carry EpiPen. Inform restaurants about allergy.",
      "isActive": true,
      "doctorName": "Dr. Smith",
      "emergencyAction": "Use EpiPen immediately and call 911",
    },
    {
      "id": "2",
      "name": "Dust Mites",
      "description": "Environmental allergy to dust mites",
      "type": "Environmental",
      "severity": "Moderate",
      "symptoms": [
        "Sneezing",
        "Runny nose",
        "Itchy eyes",
        "Congestion"
      ],
      "triggers": ["Dust", "Bedding", "Carpets", "Upholstered furniture"],
      "treatment": "Antihistamines, Nasal spray, Air purifier",
      "diagnosedDate": "2021-06-10",
      "lastReaction": "2024-01-05",
      "reactionSeverity": "Mild",
      "notes": "Use allergen-proof bedding covers",
      "isActive": true,
      "doctorName": "Dr. Johnson",
    },
    {
      "id": "3",
      "name": "Penicillin",
      "description": "Antibiotic allergy",
      "type": "Medication",
      "severity": "Severe",
      "symptoms": [
        "Skin rash",
        "Hives",
        "Swelling",
        "Difficulty breathing"
      ],
      "triggers": ["Penicillin", "Amoxicillin", "Related antibiotics"],
      "treatment": "Discontinue medication, Epinephrine if severe, Hospital care",
      "diagnosedDate": "2019-08-20",
      "lastReaction": "2022-04-12",
      "reactionSeverity": "Moderate",
      "notes": "Medical alert bracelet worn. Alternative antibiotics available.",
      "isActive": true,
      "doctorName": "Dr. Brown",
      "emergencyAction": "Stop medication immediately and seek medical attention",
    },
    {
      "id": "4",
      "name": "Bee Stings",
      "description": "Insect venom allergy",
      "type": "Insect",
      "severity": "Life-threatening",
      "symptoms": [
        "Severe swelling",
        "Difficulty breathing",
        "Drop in blood pressure",
        "Loss of consciousness"
      ],
      "triggers": ["Bee stings", "Wasp stings", "Hornet stings"],
      "treatment": "EpiPen, Emergency medical care, Venom immunotherapy",
      "diagnosedDate": "2018-07-05",
      "lastReaction": "2023-08-15",
      "reactionSeverity": "Severe",
      "notes": "Undergoing venom immunotherapy. Always carry two EpiPens.",
      "isActive": true,
      "doctorName": "Dr. Wilson",
      "emergencyAction": "Use EpiPen immediately, call 911, seek emergency care",
    },
    {
      "id": "5",
      "name": "Latex",
      "description": "Contact allergy to latex",
      "type": "Contact",
      "severity": "Moderate",
      "symptoms": [
        "Skin redness",
        "Itching",
        "Hives",
        "Contact dermatitis"
      ],
      "triggers": ["Latex gloves", "Rubber products", "Medical devices"],
      "treatment": "Avoid latex, Use vinyl/nitrile alternatives, Topical corticosteroids",
      "diagnosedDate": "2022-01-30",
      "lastReaction": "2023-12-10",
      "reactionSeverity": "Mild",
      "notes": "Inform healthcare providers. Use latex-free products.",
      "isActive": true,
      "doctorName": "Dr. Davis",
    },
    {
      "id": "6",
      "name": "Shellfish",
      "description": "Seafood allergy",
      "type": "Food",
      "severity": "Moderate",
      "symptoms": [
        "Hives",
        "Stomach cramps",
        "Nausea",
        "Vomiting"
      ],
      "triggers": ["Shrimp", "Crab", "Lobster", "Shellfish products"],
      "treatment": "Avoid shellfish, Antihistamines, EpiPen if severe",
      "diagnosedDate": "2021-11-18",
      "lastReaction": "2023-09-25",
      "reactionSeverity": "Moderate",
      "notes": "Can eat fish but not shellfish. Check restaurant preparations.",
      "isActive": true,
      "doctorName": "Dr. Taylor",
    },
    {
      "id": "7",
      "name": "Pollen",
      "description": "Seasonal allergies",
      "type": "Environmental",
      "severity": "Mild",
      "symptoms": [
        "Sneezing",
        "Runny nose",
        "Itchy eyes",
        "Throat irritation"
      ],
      "triggers": ["Tree pollen", "Grass pollen", "Ragweed", "High pollen days"],
      "treatment": "Antihistamines, Nasal spray, Eye drops",
      "diagnosedDate": "2020-05-12",
      "lastReaction": "2024-01-20",
      "reactionSeverity": "Mild",
      "notes": "Worse during spring and fall. Monitor pollen counts.",
      "isActive": true,
      "doctorName": "Dr. Anderson",
    },
    {
      "id": "8",
      "name": "Egg Whites",
      "description": "Food allergy - outgrown",
      "type": "Food",
      "severity": "Mild",
      "symptoms": [
        "Skin rash",
        "Stomach upset",
        "Mild hives"
      ],
      "triggers": ["Egg whites", "Baked goods with eggs"],
      "treatment": "Previously avoided eggs, now tolerated",
      "diagnosedDate": "2015-03-08",
      "lastReaction": "2018-06-14",
      "reactionSeverity": "Mild",
      "notes": "Outgrown as of 2019. Can now eat eggs without problems.",
      "isActive": false,
      "doctorName": "Dr. Miller",
    },
  ];
  
  List<Map<String, dynamic>> get filteredAllergies {
    return allergies.where((allergy) {
      bool matchesSeverity = selectedSeverity == "All Severities" || 
                            allergy["severity"] == selectedSeverity;
      bool matchesType = selectedType == "All Types" || 
                        allergy["type"] == selectedType;
      bool matchesSearch = searchQuery.isEmpty ||
                          allergy["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          allergy["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesActive = !showActiveOnly || allergy["isActive"] == true;
      
      return matchesSeverity && matchesType && matchesSearch && matchesActive;
    }).toList();
  }
  
  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Mild":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Severe":
        return dangerColor;
      case "Life-threatening":
        return dangerColor;
      default:
        return disabledColor;
    }
  }
  
  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Food":
        return Icons.restaurant;
      case "Environmental":
        return Icons.nature;
      case "Medication":
        return Icons.medication;
      case "Insect":
        return Icons.bug_report;
      case "Contact":
        return Icons.touch_app;
      default:
        return Icons.warning;
    }
  }
  
  void _showAllergyDetail(Map<String, dynamic> allergy) {
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getSeverityColor(allergy["severity"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      _getTypeIcon(allergy["type"]),
                      color: _getSeverityColor(allergy["severity"]),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${allergy["name"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${allergy["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getSeverityColor(allergy["severity"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: _getSeverityColor(allergy["severity"]),
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.local_hospital,
                                  color: _getSeverityColor(allergy["severity"]),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${allergy["severity"]}",
                                  style: TextStyle(
                                    color: _getSeverityColor(allergy["severity"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Severity",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
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
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: primaryColor),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  _getTypeIcon(allergy["type"]),
                                  color: primaryColor,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${allergy["type"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Type",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
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
                              color: allergy["isActive"] 
                                ? successColor.withAlpha(20)
                                : disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: allergy["isActive"] ? successColor : disabledColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  allergy["isActive"] ? Icons.check_circle : Icons.remove_circle,
                                  color: allergy["isActive"] ? successColor : disabledColor,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  allergy["isActive"] ? "Active" : "Inactive",
                                  style: TextStyle(
                                    color: allergy["isActive"] ? successColor : disabledColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Status",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    _buildDetailSection(
                      "Symptoms",
                      Icons.sick,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (allergy["symptoms"] as List).map((symptom) => 
                          Padding(
                            padding: EdgeInsets.only(bottom: spXs),
                            child: Row(
                              children: [
                                Icon(Icons.circle, size: 6, color: disabledBoldColor),
                                SizedBox(width: spSm),
                                Text("$symptom"),
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                    ),
                    SizedBox(height: spMd),
                    _buildDetailSection(
                      "Triggers",
                      Icons.warning,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (allergy["triggers"] as List).map((trigger) => 
                          Padding(
                            padding: EdgeInsets.only(bottom: spXs),
                            child: Row(
                              children: [
                                Icon(Icons.circle, size: 6, color: warningColor),
                                SizedBox(width: spSm),
                                Text("$trigger"),
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                    ),
                    SizedBox(height: spMd),
                    _buildDetailSection(
                      "Treatment",
                      Icons.medical_services,
                      Text("${allergy["treatment"]}"),
                    ),
                    if (allergy["emergencyAction"] != null) ...[
                      SizedBox(height: spMd),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: dangerColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.emergency, color: dangerColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Emergency Action",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                    fontSize: fsH6,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${allergy["emergencyAction"]}",
                              style: TextStyle(
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Medical Information",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fsH6,
                            ),
                          ),
                          SizedBox(height: spSm),
                          _buildDetailRow("Diagnosed Date", DateTime.parse(allergy["diagnosedDate"]).dMMMy),
                          if (allergy["lastReaction"] != null)
                            _buildDetailRow("Last Reaction", DateTime.parse(allergy["lastReaction"]).dMMMy),
                          if (allergy["doctorName"] != null)
                            _buildDetailRow("Doctor", allergy["doctorName"]),
                        ],
                      ),
                    ),
                    if (allergy["notes"] != null && allergy["notes"].toString().isNotEmpty) ...[
                      SizedBox(height: spMd),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: secondaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Notes",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fsH6,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${allergy["notes"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Edit Allergy",
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {
                              Navigator.pop(context);
                              _showEditAllergyDialog(allergy);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: allergy["isActive"] ? "Mark Inactive" : "Mark Active",
                            icon: allergy["isActive"] ? Icons.remove_circle : Icons.check_circle,
                            size: bs.sm,
                            onPressed: () {
                              setState(() {
                                allergy["isActive"] = !allergy["isActive"];
                              });
                              Navigator.pop(context);
                              ss(allergy["isActive"] 
                                ? "Allergy marked as active" 
                                : "Allergy marked as inactive");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailSection(String title, IconData icon, Widget content) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fsH6,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          content,
        ],
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showEditAllergyDialog(Map<String, dynamic> allergy) {
    // Pre-fill form with existing data
    allergyName = allergy["name"];
    allergyDescription = allergy["description"];
    selectedAllergyType = allergy["type"];
    selectedSeverityLevel = allergy["severity"];
    symptoms = (allergy["symptoms"] as List).join(", ");
    triggers = (allergy["triggers"] as List).join(", ");
    treatment = allergy["treatment"];
    notes = allergy["notes"] ?? "";
    diagnosedDate = allergy["diagnosedDate"];
    isActive = allergy["isActive"];
    
    _showAddAllergyDialog(isEdit: true, existingAllergy: allergy);
  }
  
  void _showAddAllergyDialog({bool isEdit = false, Map<String, dynamic>? existingAllergy}) {
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      isEdit ? "Edit Allergy" : "Add New Allergy",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: [
                      QTextField(
                        label: "Allergy Name",
                        value: allergyName,
                        validator: Validator.required,
                        hint: "e.g., Peanuts, Dust Mites",
                        onChanged: (value) {
                          allergyName = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QMemoField(
                        label: "Description",
                        value: allergyDescription,
                        hint: "Brief description of the allergy",
                        onChanged: (value) {
                          allergyDescription = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Expanded(
                            child: QDropdownField(
                              label: "Type",
                              items: typeOptions.where((type) => type["value"] != "All Types").toList(),
                              value: selectedAllergyType,
                              onChanged: (value, label) {
                                selectedAllergyType = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "Severity",
                              items: severityOptions.where((severity) => severity["value"] != "All Severities").toList(),
                              value: selectedSeverityLevel,
                              onChanged: (value, label) {
                                selectedSeverityLevel = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      QMemoField(
                        label: "Symptoms",
                        value: symptoms,
                        hint: "List symptoms separated by commas",
                        onChanged: (value) {
                          symptoms = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QMemoField(
                        label: "Triggers",
                        value: triggers,
                        hint: "List triggers separated by commas",
                        onChanged: (value) {
                          triggers = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QMemoField(
                        label: "Treatment",
                        value: treatment,
                        hint: "Describe treatment plan",
                        onChanged: (value) {
                          treatment = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QDatePicker(
                        label: "Diagnosed Date",
                        value: DateTime.parse(diagnosedDate),
                        onChanged: (value) {
                          diagnosedDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QSwitch(
                        label: "Currently Active",
                        items: [
                          {
                            "label": "Active allergy",
                            "value": true,
                            "checked": isActive,
                          }
                        ],
                        value: [if (isActive) {"label": "Active allergy", "value": true, "checked": true}],
                        onChanged: (values, ids) {
                          setState(() {
                            isActive = values.isNotEmpty;
                          });
                        },
                      ),
                      SizedBox(height: spMd),
                      QMemoField(
                        label: "Additional Notes",
                        value: notes,
                        hint: "Any additional information",
                        onChanged: (value) {
                          notes = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: isEdit ? "Update Allergy" : "Add Allergy",
                          icon: isEdit ? Icons.update : Icons.add,
                          size: bs.md,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (isEdit && existingAllergy != null) {
                                // Update existing allergy
                                setState(() {
                                  existingAllergy["name"] = allergyName;
                                  existingAllergy["description"] = allergyDescription;
                                  existingAllergy["type"] = selectedAllergyType;
                                  existingAllergy["severity"] = selectedSeverityLevel;
                                  existingAllergy["symptoms"] = symptoms.split(',').map((s) => s.trim()).toList();
                                  existingAllergy["triggers"] = triggers.split(',').map((s) => s.trim()).toList();
                                  existingAllergy["treatment"] = treatment;
                                  existingAllergy["diagnosedDate"] = diagnosedDate;
                                  existingAllergy["isActive"] = isActive;
                                  existingAllergy["notes"] = notes;
                                });
                                ss("Allergy updated successfully");
                              } else {
                                // Add new allergy
                                setState(() {
                                  allergies.add({
                                    "id": DateTime.now().millisecondsSinceEpoch.toString(),
                                    "name": allergyName,
                                    "description": allergyDescription,
                                    "type": selectedAllergyType,
                                    "severity": selectedSeverityLevel,
                                    "symptoms": symptoms.split(',').map((s) => s.trim()).toList(),
                                    "triggers": triggers.split(',').map((s) => s.trim()).toList(),
                                    "treatment": treatment,
                                    "diagnosedDate": diagnosedDate,
                                    "isActive": isActive,
                                    "notes": notes,
                                  });
                                });
                                ss("Allergy added successfully");
                              }
                              
                              // Reset form
                              allergyName = "";
                              allergyDescription = "";
                              selectedAllergyType = "Food";
                              selectedSeverityLevel = "Mild";
                              symptoms = "";
                              triggers = "";
                              treatment = "";
                              notes = "";
                              diagnosedDate = DateTime.now().toString().split(' ')[0];
                              isActive = true;
                              
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatsCard() {
    int totalAllergies = allergies.length;
    int activeAllergies = allergies.where((a) => a["isActive"] == true).length;
    int severeAllergies = allergies.where((a) => a["severity"] == "Severe" || a["severity"] == "Life-threatening").length;
    int foodAllergies = allergies.where((a) => a["type"] == "Food" && a["isActive"] == true).length;
    
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
          Row(
            children: [
              Icon(Icons.warning, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Allergy Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$totalAllergies",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$activeAllergies",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$severeAllergies",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Severe",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$foodAllergies",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Food",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
    );
  }
  
  Widget _buildAllergyCard(Map<String, dynamic> allergy) {
    bool isSevere = allergy["severity"] == "Severe" || allergy["severity"] == "Life-threatening";
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isSevere ? Border.all(color: dangerColor, width: 2) : 
                !allergy["isActive"] ? Border.all(color: disabledColor) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getSeverityColor(allergy["severity"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  _getTypeIcon(allergy["type"]),
                  color: _getSeverityColor(allergy["severity"]),
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
                          "${allergy["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (!allergy["isActive"]) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Inactive",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${allergy["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getSeverityColor(allergy["severity"]),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${allergy["severity"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${allergy["type"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.date_range, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Diagnosed: ${DateTime.parse(allergy["diagnosedDate"]).dMMMy}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          if (allergy["lastReaction"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.history, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "Last reaction: ${DateTime.parse(allergy["lastReaction"]).dMMMy}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spSm),
          Text(
            "Symptoms:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          SizedBox(height: spXs),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (allergy["symptoms"] as List).take(3).map((symptom) => 
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$symptom",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 10,
                  ),
                ),
              ),
            ).toList(),
          ),
          if ((allergy["symptoms"] as List).length > 3) ...[
            SizedBox(height: spXs),
            Text(
              "+${(allergy["symptoms"] as List).length - 3} more symptoms",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 10,
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showAllergyDetail(allergy),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _showEditAllergyDialog(allergy),
              ),
              if (isSevere) ...[
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.emergency,
                  size: bs.sm,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Emergency Action"),
                        content: Text("${allergy["emergencyAction"] ?? "Seek immediate medical attention"}"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Close"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Simulate emergency call
                              ss("Emergency services contacted");
                            },
                            child: Text("Call 911"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Allergy Tracker"),
        actions: [
          GestureDetector(
            onTap: () => _showAddAllergyDialog(),
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCard(),
            SizedBox(height: spMd),
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
                  Text(
                    "Filter & Search",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Search Allergies",
                    value: searchQuery,
                    hint: "Search by name or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: typeOptions,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Severity",
                          items: severityOptions,
                          value: selectedSeverity,
                          onChanged: (value, label) {
                            selectedSeverity = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    label: "Show Active Only",
                    items: [
                      {
                        "label": "Active allergies only",
                        "value": true,
                        "checked": showActiveOnly,
                      }
                    ],
                    value: [if (showActiveOnly) {"label": "Active allergies only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      setState(() {
                        showActiveOnly = values.isNotEmpty;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Text(
                  "My Allergies",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${filteredAllergies.length}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            if (filteredAllergies.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.warning,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No allergies found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or add a new allergy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredAllergies.map((allergy) => _buildAllergyCard(allergy)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHealth8View extends StatefulWidget {
  @override
  State<GrlHealth8View> createState() => _GrlHealth8ViewState();
}

class _GrlHealth8ViewState extends State<GrlHealth8View> {
  String selectedTab = "symptoms";
  String selectedSymptom = "";
  String symptomDescription = "";
  String painLevel = "";
  String duration = "";
  List<String> associatedSymptoms = [];
  String urgencyLevel = "low";

  List<Map<String, dynamic>> symptomCategories = [
    {
      "id": "head_neck",
      "name": "Head & Neck",
      "symptoms": ["Headache", "Neck pain", "Dizziness", "Sore throat", "Jaw pain"],
      "icon": Icons.face,
      "color": Colors.blue
    },
    {
      "id": "chest_breathing",
      "name": "Chest & Breathing",
      "symptoms": ["Chest pain", "Shortness of breath", "Cough", "Wheezing", "Heart palpitations"],
      "icon": Icons.favorite,
      "color": Colors.red
    },
    {
      "id": "digestive",
      "name": "Digestive",
      "symptoms": ["Nausea", "Vomiting", "Diarrhea", "Constipation", "Stomach pain", "Loss of appetite"],
      "icon": Icons.restaurant,
      "color": Colors.orange
    },
    {
      "id": "musculoskeletal",
      "name": "Muscles & Joints",
      "symptoms": ["Back pain", "Joint pain", "Muscle cramps", "Swelling", "Stiffness"],
      "icon": Icons.accessibility,
      "color": Colors.green
    },
    {
      "id": "skin",
      "name": "Skin",
      "symptoms": ["Rash", "Itching", "Bruising", "Wounds", "Swelling"],
      "icon": Icons.healing,
      "color": Colors.purple
    },
    {
      "id": "neurological",
      "name": "Neurological",
      "symptoms": ["Confusion", "Memory loss", "Numbness", "Tingling", "Weakness"],
      "icon": Icons.psychology,
      "color": Colors.indigo
    }
  ];

  List<Map<String, dynamic>> commonSymptoms = [
    {"name": "Fever", "severity": "moderate", "icon": Icons.thermostat},
    {"name": "Fatigue", "severity": "mild", "icon": Icons.battery_2_bar},
    {"name": "Headache", "severity": "mild", "icon": Icons.face},
    {"name": "Nausea", "severity": "moderate", "icon": Icons.sick},
    {"name": "Dizziness", "severity": "mild", "icon": Icons.blur_on},
    {"name": "Loss of appetite", "severity": "mild", "icon": Icons.no_food},
  ];

  List<Map<String, dynamic>> urgencyLevels = [
    {
      "id": "low",
      "name": "Low Priority",
      "description": "Mild symptoms, can wait for regular appointment",
      "color": Colors.green,
      "icon": Icons.schedule
    },
    {
      "id": "medium",
      "name": "Medium Priority",
      "description": "Moderate symptoms, should be seen within 24-48 hours",
      "color": Colors.orange,
      "icon": Icons.warning
    },
    {
      "id": "high",
      "name": "High Priority",
      "description": "Severe symptoms, needs immediate medical attention",
      "color": Colors.red,
      "icon": Icons.priority_high
    },
    {
      "id": "emergency",
      "name": "Emergency",
      "description": "Life-threatening symptoms, call emergency services",
      "color": Colors.red.shade800,
      "icon": Icons.emergency
    }
  ];

  List<Map<String, dynamic>> painLevels = [
    {"label": "No Pain (0)", "value": "0"},
    {"label": "Mild (1-3)", "value": "1-3"},
    {"label": "Moderate (4-6)", "value": "4-6"},
    {"label": "Severe (7-8)", "value": "7-8"},
    {"label": "Worst Pain (9-10)", "value": "9-10"},
  ];

  List<Map<String, dynamic>> durationOptions = [
    {"label": "Less than 1 hour", "value": "less_1h"},
    {"label": "1-6 hours", "value": "1-6h"},
    {"label": "6-24 hours", "value": "6-24h"},
    {"label": "1-3 days", "value": "1-3d"},
    {"label": "1 week", "value": "1w"},
    {"label": "More than 1 week", "value": "more_1w"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Symptom Checker"),
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "symptoms";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == "symptoms" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Select Symptoms",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "symptoms" ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "details";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == "details" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Symptom Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "details" ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "assessment";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == "assessment" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Assessment",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "assessment" ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "symptoms":
        return _buildSymptomSelection();
      case "details":
        return _buildSymptomDetails();
      case "assessment":
        return _buildAssessment();
      default:
        return Container();
    }
  }

  Widget _buildSymptomSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue.withAlpha(200)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "What are you experiencing?",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Select the symptoms you're currently experiencing",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.medical_services,
                color: Colors.white,
                size: 48,
              ),
            ],
          ),
        ),

        // Common Symptoms Quick Access
        Text(
          "Common Symptoms",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: commonSymptoms.map((symptom) {
              bool isSelected = selectedSymptom == symptom["name"];
              Color severityColor = Colors.green;
              if (symptom["severity"] == "moderate") severityColor = Colors.orange;
              if (symptom["severity"] == "severe") severityColor = Colors.red;

              return GestureDetector(
                onTap: () {
                  selectedSymptom = symptom["name"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(50) : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        symptom["icon"] as IconData,
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${symptom["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: severityColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${symptom["severity"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: severityColor,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Container(
                          margin: EdgeInsets.only(left: spSm),
                          child: Icon(
                            Icons.check_circle,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // Symptom Categories
        Text(
          "Browse by Category",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: symptomCategories.map((category) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (category["color"] as Color).withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          category["icon"] as IconData,
                          color: category["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${category["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...((category["symptoms"] as List<String>).take(3).map((symptom) {
                    bool isSelected = selectedSymptom == symptom;
                    return GestureDetector(
                      onTap: () {
                        selectedSymptom = symptom;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(50) : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                              color: isSelected ? primaryColor : disabledBoldColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                symptom,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()),
                  if ((category["symptoms"] as List<String>).length > 3)
                    GestureDetector(
                      onTap: () {
                        si("View more ${category["name"]} symptoms");
                      },
                      child: Text(
                        "+${(category["symptoms"] as List<String>).length - 3} more",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSymptomDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Selected Symptom Header
        if (selectedSymptom.isNotEmpty)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor),
                SizedBox(width: spSm),
                Text(
                  "Primary Symptom: $selectedSymptom",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

        if (selectedSymptom.isEmpty)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: Colors.orange),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Please select a primary symptom first from the Symptoms tab",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),

        if (selectedSymptom.isNotEmpty) ...[
          Text(
            "Symptom Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          QMemoField(
            label: "Describe your symptom",
            value: symptomDescription,
            hint: "Provide more details about what you're experiencing",
            onChanged: (value) {
              symptomDescription = value;
              setState(() {});
            },
          ),

          QDropdownField(
            label: "Pain/Discomfort Level",
            items: painLevels,
            value: painLevel,
            onChanged: (value, label) {
              painLevel = value;
              setState(() {});
            },
          ),

          QDropdownField(
            label: "How long have you had this symptom?",
            items: durationOptions,
            value: duration,
            onChanged: (value, label) {
              duration = value;
              setState(() {});
            },
          ),

          Text(
            "Associated Symptoms",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Select any additional symptoms you're experiencing:",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                ...commonSymptoms.where((s) => s["name"] != selectedSymptom).map((symptom) {
                  bool isSelected = associatedSymptoms.contains(symptom["name"]);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        associatedSymptoms.remove(symptom["name"]);
                      } else {
                        associatedSymptoms.add(symptom["name"]);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(50) : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                            color: isSelected ? primaryColor : disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${symptom["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAssessment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Summary
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.green.withAlpha(200)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Symptom Assessment",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (selectedSymptom.isNotEmpty)
                Text(
                  "Based on your reported symptoms",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
            ],
          ),
        ),

        if (selectedSymptom.isEmpty)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Column(
              children: [
                Icon(Icons.warning, color: Colors.orange, size: 48),
                SizedBox(height: spSm),
                Text(
                  "No Symptoms Selected",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                ),
                Text(
                  "Please go back to the first tab and select your symptoms to get an assessment.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange.shade600,
                  ),
                ),
              ],
            ),
          ),

        if (selectedSymptom.isNotEmpty) ...[
          // Priority Level Selection
          Text(
            "Urgency Assessment",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...urgencyLevels.map((urgency) {
            bool isSelected = urgencyLevel == urgency["id"];
            return GestureDetector(
              onTap: () {
                urgencyLevel = urgency["id"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? (urgency["color"] as Color).withAlpha(50) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isSelected ? urgency["color"] as Color : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (urgency["color"] as Color).withAlpha(100),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        urgency["icon"] as IconData,
                        color: urgency["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${urgency["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${urgency["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: urgency["color"] as Color,
                        size: 24,
                      ),
                  ],
                ),
              ),
            );
          }).toList(),

          // Recommendations
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.blue),
                    SizedBox(width: spSm),
                    Text(
                      "Recommendations",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
                if (urgencyLevel == "emergency")
                  Text(
                    "🚨 Call emergency services immediately (911)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                if (urgencyLevel == "high")
                  Text(
                    "• Seek immediate medical attention\n• Visit emergency room or urgent care\n• Contact your healthcare provider",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade700,
                    ),
                  ),
                if (urgencyLevel == "medium")
                  Text(
                    "• Schedule appointment within 24-48 hours\n• Monitor symptoms closely\n• Contact provider if symptoms worsen",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade700,
                    ),
                  ),
                if (urgencyLevel == "low")
                  Text(
                    "• Schedule routine appointment\n• Rest and stay hydrated\n• Monitor symptoms for changes",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade700,
                    ),
                  ),
              ],
            ),
          ),

          // Action Buttons
          if (urgencyLevel == "emergency")
            Container(
              width: double.infinity,
              child: QButton(
                label: "🚨 Call Emergency Services",
                size: bs.md,
                onPressed: () {
                  si("Connecting to emergency services...");
                },
              ),
            ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Book Appointment",
                  size: bs.sm,
                  onPressed: () {
                    si("Redirecting to appointment booking...");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save Assessment",
                  size: bs.sm,
                  onPressed: () {
                    ss("Symptom assessment saved to your health records");
                  },
                ),
              ),
            ],
          ),

          // Disclaimer
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "⚠️ Medical Disclaimer",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "This assessment is for informational purposes only and should not replace professional medical advice. Always consult with a qualified healthcare provider for proper diagnosis and treatment.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

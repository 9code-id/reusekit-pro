import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaSymptomCheckerView extends StatefulWidget {
  const HcaSymptomCheckerView({super.key});

  @override
  State<HcaSymptomCheckerView> createState() => _HcaSymptomCheckerViewState();
}

class _HcaSymptomCheckerViewState extends State<HcaSymptomCheckerView> {
  int currentStep = 0;
  List<String> selectedSymptoms = [];
  String selectedSeverity = "";
  String selectedDuration = "";
  String additionalNotes = "";
  bool hasCheckedResults = false;

  List<Map<String, dynamic>> symptomCategories = [
    {
      "category": "General",
      "icon": Icons.person,
      "symptoms": ["Fever", "Fatigue", "Weakness", "Loss of appetite", "Weight loss", "Night sweats"]
    },
    {
      "category": "Respiratory",
      "icon": Icons.air,
      "symptoms": ["Cough", "Shortness of breath", "Chest pain", "Sore throat", "Runny nose", "Sneezing"]
    },
    {
      "category": "Digestive",
      "icon": Icons.restaurant,
      "symptoms": ["Nausea", "Vomiting", "Diarrhea", "Constipation", "Abdominal pain", "Heartburn"]
    },
    {
      "category": "Neurological",
      "icon": Icons.psychology,
      "symptoms": ["Headache", "Dizziness", "Confusion", "Memory problems", "Numbness", "Tingling"]
    },
    {
      "category": "Musculoskeletal",
      "icon": Icons.accessibility,
      "symptoms": ["Joint pain", "Muscle pain", "Back pain", "Stiffness", "Swelling", "Limited mobility"]
    },
    {
      "category": "Skin",
      "icon": Icons.healing,
      "symptoms": ["Rash", "Itching", "Dry skin", "Bruising", "Changes in moles", "Hair loss"]
    },
  ];

  List<Map<String, dynamic>> severityLevels = [
    {"label": "Mild", "value": "mild", "description": "Slight discomfort, doesn't interfere with daily activities"},
    {"label": "Moderate", "value": "moderate", "description": "Noticeable symptoms that may affect some activities"},
    {"label": "Severe", "value": "severe", "description": "Significant symptoms that interfere with daily life"},
    {"label": "Critical", "value": "critical", "description": "Emergency symptoms requiring immediate medical attention"},
  ];

  List<Map<String, dynamic>> durationOptions = [
    {"label": "Less than 1 day", "value": "less_than_1_day"},
    {"label": "1-3 days", "value": "1_3_days"},
    {"label": "4-7 days", "value": "4_7_days"},
    {"label": "1-2 weeks", "value": "1_2_weeks"},
    {"label": "2-4 weeks", "value": "2_4_weeks"},
    {"label": "More than 1 month", "value": "more_than_1_month"},
  ];

  Map<String, dynamic> assessmentResults = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Symptom Checker"),
        actions: [
          if (hasCheckedResults)
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetChecker();
              },
            ),
        ],
      ),
      body: hasCheckedResults ? _buildResults() : _buildSymptomChecker(),
    );
  }

  Widget _buildSymptomChecker() {
    return Column(
      children: [
        _buildProgressIndicator(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: _buildCurrentStep(),
          ),
        ),
        _buildNavigationButtons(),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ...List.generate(4, (index) {
                bool isActive = index <= currentStep;
                bool isCompleted = index < currentStep;
                
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: isActive ? primaryColor : disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                );
              }),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Step ${currentStep + 1} of 4",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            _getStepTitle(),
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (currentStep) {
      case 0: return "Select your symptoms";
      case 1: return "Choose severity level";
      case 2: return "Duration of symptoms";
      case 3: return "Additional information";
      default: return "";
    }
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildSymptomSelection();
      case 1:
        return _buildSeveritySelection();
      case 2:
        return _buildDurationSelection();
      case 3:
        return _buildAdditionalInfo();
      default:
        return Container();
    }
  }

  Widget _buildSymptomSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Select all symptoms you're currently experiencing. You can choose from multiple categories.",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (selectedSymptoms.isNotEmpty)
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
                  "Selected Symptoms (${selectedSymptoms.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: selectedSymptoms.map((symptom) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            symptom,
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () {
                              selectedSymptoms.remove(symptom);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.close,
                              color: primaryColor,
                              size: 14,
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
        ...symptomCategories.map((category) => _buildSymptomCategory(category)),
      ],
    );
  }

  Widget _buildSymptomCategory(Map<String, dynamic> category) {
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
              Icon(
                category["icon"] as IconData,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "${category["category"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (category["symptoms"] as List<String>).map((symptom) {
              bool isSelected = selectedSymptoms.contains(symptom);
              
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    selectedSymptoms.remove(symptom);
                  } else {
                    selectedSymptoms.add(symptom);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : disabledColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    symptom,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? primaryColor : disabledBoldColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSeveritySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "How severe are your symptoms overall? Consider the worst symptom you're experiencing.",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...severityLevels.map((level) => _buildSeverityOption(level)),
      ],
    );
  }

  Widget _buildSeverityOption(Map<String, dynamic> level) {
    bool isSelected = selectedSeverity == level["value"];
    Color levelColor = _getSeverityColor(level["value"] as String);
    
    return GestureDetector(
      onTap: () {
        selectedSeverity = level["value"] as String;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? levelColor.withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? levelColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? levelColor : disabledColor,
                shape: BoxShape.circle,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    )
                  : null,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${level["label"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? levelColor : disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${level["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? levelColor : disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "mild":
        return successColor;
      case "moderate":
        return warningColor;
      case "severe":
        return dangerColor;
      case "critical":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  Widget _buildDurationSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "How long have you been experiencing these symptoms?",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: QDropdownField(
            label: "Duration of symptoms",
            items: durationOptions,
            value: selectedDuration,
            onChanged: (value, label) {
              selectedDuration = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Provide any additional information that might be relevant to your symptoms.",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: QMemoField(
            label: "Additional notes",
            value: additionalNotes,
            hint: "Include any relevant information such as triggers, medications, recent activities, etc.",
            onChanged: (value) {
              additionalNotes = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: QButton(
                label: "Previous",
                size: bs.sm,
                onPressed: () {
                  currentStep--;
                  setState(() {});
                },
              ),
            ),
          if (currentStep > 0) SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: currentStep == 3 ? "Get Assessment" : "Next",
              size: bs.sm,
              onPressed: () {
                if (_canProceed()) {
                  if (currentStep == 3) {
                    _generateAssessment();
                  } else {
                    currentStep++;
                    setState(() {});
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedSymptoms.isNotEmpty;
      case 1:
        return selectedSeverity.isNotEmpty;
      case 2:
        return selectedDuration.isNotEmpty;
      case 3:
        return true;
      default:
        return false;
    }
  }

  Widget _buildResults() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAssessmentHeader(),
          _buildSymptomsSummary(),
          _buildRecommendations(),
          _buildDisclaimerAndActions(),
        ],
      ),
    );
  }

  Widget _buildAssessmentHeader() {
    Color urgencyColor = _getUrgencyColor();
    IconData urgencyIcon = _getUrgencyIcon();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: urgencyColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: urgencyColor,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            urgencyIcon,
            color: urgencyColor,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            "${assessmentResults["urgencyLevel"]}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: urgencyColor,
            ),
          ),
          Text(
            "${assessmentResults["urgencyMessage"]}",
            style: TextStyle(
              fontSize: 14,
              color: urgencyColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsSummary() {
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
            "Symptoms Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildSummaryRow("Symptoms", "${selectedSymptoms.length} selected"),
          _buildSummaryRow("Severity", selectedSeverity.toUpperCase()),
          _buildSummaryRow("Duration", _getDurationLabel()),
          if (additionalNotes.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Additional Notes:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  additionalNotes,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendations() {
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
            "Recommendations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...(assessmentResults["recommendations"] as List<String>).map(
            (recommendation) => _buildRecommendationItem(recommendation),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String recommendation) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            recommendation,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDisclaimerAndActions() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: warningColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Important Disclaimer",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              Text(
                "This assessment is for informational purposes only and should not replace professional medical advice. If you have concerns about your health, please consult with a healthcare provider.",
                style: TextStyle(
                  fontSize: 11,
                  color: warningColor,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "New Assessment",
                size: bs.sm,
                onPressed: () {
                  _resetChecker();
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Find Doctor",
                size: bs.sm,
                onPressed: () {
                  si("Finding nearby healthcare providers");
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getDurationLabel() {
    Map<String, String> durationLabels = {
      "less_than_1_day": "Less than 1 day",
      "1_3_days": "1-3 days",
      "4_7_days": "4-7 days",
      "1_2_weeks": "1-2 weeks",
      "2_4_weeks": "2-4 weeks",
      "more_than_1_month": "More than 1 month",
    };
    return durationLabels[selectedDuration] ?? selectedDuration;
  }

  Color _getUrgencyColor() {
    switch (assessmentResults["urgencyLevel"]) {
      case "EMERGENCY":
        return dangerColor;
      case "URGENT":
        return warningColor;
      case "ROUTINE":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getUrgencyIcon() {
    switch (assessmentResults["urgencyLevel"]) {
      case "EMERGENCY":
        return Icons.emergency;
      case "URGENT":
        return Icons.warning;
      case "ROUTINE":
        return Icons.info;
      default:
        return Icons.health_and_safety;
    }
  }

  void _generateAssessment() {
    String urgencyLevel = "ROUTINE";
    String urgencyMessage = "Consider scheduling a routine check-up";
    List<String> recommendations = [
      "Monitor your symptoms over the next few days",
      "Stay hydrated and get adequate rest",
      "Consider over-the-counter medications if appropriate",
      "Contact your healthcare provider if symptoms worsen",
    ];

    // Determine urgency based on severity and symptoms
    if (selectedSeverity == "critical" || selectedSymptoms.any((s) => 
        ["Difficulty breathing", "Chest pain", "Severe headache"].contains(s))) {
      urgencyLevel = "EMERGENCY";
      urgencyMessage = "Seek immediate medical attention";
      recommendations = [
        "Call 911 or go to the nearest emergency room immediately",
        "Do not drive yourself - have someone else drive you",
        "Bring a list of your current medications",
        "Stay calm and follow emergency instructions",
      ];
    } else if (selectedSeverity == "severe" || selectedDuration == "more_than_1_month") {
      urgencyLevel = "URGENT";
      urgencyMessage = "Contact your healthcare provider soon";
      recommendations = [
        "Schedule an appointment with your doctor within 24-48 hours",
        "Keep a symptom diary to track changes",
        "Avoid activities that worsen symptoms",
        "Consider urgent care if your doctor is unavailable",
      ];
    }

    assessmentResults = {
      "urgencyLevel": urgencyLevel,
      "urgencyMessage": urgencyMessage,
      "recommendations": recommendations,
    };

    hasCheckedResults = true;
    setState(() {});
  }

  void _resetChecker() {
    currentStep = 0;
    selectedSymptoms.clear();
    selectedSeverity = "";
    selectedDuration = "";
    additionalNotes = "";
    hasCheckedResults = false;
    assessmentResults.clear();
    setState(() {});
  }
}

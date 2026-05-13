import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaSymptomCheckerView extends StatefulWidget {
  const MhaSymptomCheckerView({super.key});

  @override
  State<MhaSymptomCheckerView> createState() => _MhaSymptomCheckerViewState();
}

class _MhaSymptomCheckerViewState extends State<MhaSymptomCheckerView> {
  int currentStep = 0;
  List<String> selectedSymptoms = [];
  String selectedBodyPart = "";
  String painLevel = "1";
  String duration = "";
  String additionalInfo = "";
  
  final bodyParts = [
    {"label": "Head", "value": "Head", "icon": Icons.face},
    {"label": "Neck", "value": "Neck", "icon": Icons.person},
    {"label": "Chest", "value": "Chest", "icon": Icons.favorite},
    {"label": "Abdomen", "value": "Abdomen", "icon": Icons.circle},
    {"label": "Back", "value": "Back", "icon": Icons.person},
    {"label": "Arms", "value": "Arms", "icon": Icons.pan_tool},
    {"label": "Legs", "value": "Legs", "icon": Icons.directions_walk},
    {"label": "Other", "value": "Other", "icon": Icons.more_horiz},
  ];

  final commonSymptoms = [
    {
      "category": "General",
      "symptoms": [
        "Fever",
        "Fatigue",
        "Weakness",
        "Loss of appetite",
        "Weight loss",
        "Night sweats",
        "Chills",
        "Dizziness"
      ]
    },
    {
      "category": "Pain",
      "symptoms": [
        "Headache",
        "Back pain",
        "Joint pain",
        "Muscle pain",
        "Chest pain",
        "Abdominal pain",
        "Neck pain",
        "Toothache"
      ]
    },
    {
      "category": "Respiratory",
      "symptoms": [
        "Cough",
        "Shortness of breath",
        "Runny nose",
        "Sore throat",
        "Sneezing",
        "Wheezing",
        "Congestion",
        "Difficulty breathing"
      ]
    },
    {
      "category": "Digestive",
      "symptoms": [
        "Nausea",
        "Vomiting",
        "Diarrhea",
        "Constipation",
        "Bloating",
        "Heartburn",
        "Loss of appetite",
        "Stomach pain"
      ]
    },
    {
      "category": "Skin",
      "symptoms": [
        "Rash",
        "Itching",
        "Dry skin",
        "Bumps",
        "Redness",
        "Swelling",
        "Bruising",
        "Changes in moles"
      ]
    },
    {
      "category": "Mental Health",
      "symptoms": [
        "Anxiety",
        "Depression",
        "Stress",
        "Insomnia",
        "Mood changes",
        "Confusion",
        "Memory problems",
        "Irritability"
      ]
    },
  ];

  final painLevels = [
    {"label": "1 - Minimal", "value": "1"},
    {"label": "2 - Mild", "value": "2"},
    {"label": "3 - Moderate", "value": "3"},
    {"label": "4 - Severe", "value": "4"},
    {"label": "5 - Extreme", "value": "5"},
  ];

  final durationOptions = [
    {"label": "Less than 1 day", "value": "< 1 day"},
    {"label": "1-3 days", "value": "1-3 days"},
    {"label": "3-7 days", "value": "3-7 days"},
    {"label": "1-2 weeks", "value": "1-2 weeks"},
    {"label": "2-4 weeks", "value": "2-4 weeks"},
    {"label": "More than 1 month", "value": "> 1 month"},
  ];

  final suggestions = [
    {
      "condition": "Common Cold",
      "probability": 85,
      "description": "Based on your symptoms, you may have a common cold.",
      "recommendations": [
        "Get plenty of rest",
        "Drink lots of fluids",
        "Use throat lozenges for sore throat",
        "Consider over-the-counter medications"
      ],
      "warning": "See a doctor if symptoms worsen or persist beyond 10 days",
      "color": 0xFF4CAF50
    },
    {
      "condition": "Stress/Anxiety",
      "probability": 65,
      "description": "Your symptoms may be related to stress or anxiety.",
      "recommendations": [
        "Practice relaxation techniques",
        "Exercise regularly",
        "Maintain a healthy sleep schedule",
        "Consider talking to someone"
      ],
      "warning": "Seek professional help if symptoms persist or interfere with daily life",
      "color": 0xFF2196F3
    },
    {
      "condition": "Digestive Issues",
      "probability": 45,
      "description": "You may be experiencing digestive problems.",
      "recommendations": [
        "Eat bland, easy-to-digest foods",
        "Stay hydrated",
        "Avoid fatty or spicy foods",
        "Consider probiotics"
      ],
      "warning": "See a doctor if symptoms persist for more than 3 days",
      "color": 0xFFFF9800
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Symptom Checker"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Step ${currentStep + 1} of 5",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${((currentStep + 1) / 5 * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: (currentStep + 1) / 5,
                  backgroundColor: disabledColor.withAlpha(30),
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),

          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildStepContent(),
            ),
          ),

          // Navigation Buttons
          Container(
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
                      size: bs.md,
                      onPressed: () {
                        if (currentStep > 0) {
                          currentStep--;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: currentStep == 4 ? "Get Results" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentStep < 4) {
                        currentStep++;
                        setState(() {});
                      } else {
                        // Show results
                        _showResults();
                      }
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

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildSymptomSelection();
      case 1:
        return _buildBodyPartSelection();
      case 2:
        return _buildPainLevel();
      case 3:
        return _buildDuration();
      case 4:
        return _buildAdditionalInfo();
      default:
        return Container();
    }
  }

  Widget _buildSymptomSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(30)),
          ),
          child: Row(
            children: [
              Icon(Icons.medical_services, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What symptoms are you experiencing?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Select all symptoms that apply to you",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Selected Symptoms Summary
        if (selectedSymptoms.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selected Symptoms (${selectedSymptoms.length})",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spXs),
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
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            symptom,
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
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
                              size: 14,
                              color: successColor,
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
          SizedBox(height: spMd),
        ],

        // Symptom Categories
        ...commonSymptoms.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                child: Text(
                  "${category["category"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 140,
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
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? primaryColor.withAlpha(20) 
                            : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                        border: isSelected 
                            ? Border.all(color: primaryColor, width: 2)
                            : Border.all(color: disabledColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              symptom,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                color: isSelected ? primaryColor : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: spMd),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildBodyPartSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(30)),
          ),
          child: Row(
            children: [
              Icon(Icons.accessibility, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Which part of your body is affected?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Select the primary area where you feel discomfort",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: spMd),

        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 140,
          children: bodyParts.map((part) {
            bool isSelected = selectedBodyPart == part["value"];
            
            return GestureDetector(
              onTap: () {
                selectedBodyPart = part["value"] as String;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? primaryColor.withAlpha(20) 
                      : Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: isSelected 
                      ? Border.all(color: primaryColor, width: 2)
                      : Border.all(color: disabledColor.withAlpha(30)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? primaryColor.withAlpha(30)
                            : disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        part["icon"] as IconData,
                        size: 32,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${part["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? primaryColor : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPainLevel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(30)),
          ),
          child: Row(
            children: [
              Icon(Icons.sentiment_very_dissatisfied, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How would you rate your discomfort?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Rate your pain or discomfort level from 1 to 5",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: spMd),

        QDropdownField(
          label: "Pain/Discomfort Level",
          items: painLevels,
          value: painLevel,
          onChanged: (value, label) {
            painLevel = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Visual Pain Scale
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pain Scale Reference",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              ...painLevels.map((level) {
                bool isSelected = painLevel == level["value"];
                Color levelColor = _getPainColor(int.parse(level["value"] as String));
                
                return Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? levelColor.withAlpha(20) 
                        : levelColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: isSelected 
                        ? Border.all(color: levelColor, width: 2)
                        : Border.all(color: levelColor.withAlpha(30)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: levelColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${level["value"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${level["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? levelColor : null,
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
    );
  }

  Widget _buildDuration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(30)),
          ),
          child: Row(
            children: [
              Icon(Icons.schedule, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How long have you had these symptoms?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Select the duration of your symptoms",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: spMd),

        QDropdownField(
          label: "Symptom Duration",
          items: durationOptions,
          value: duration,
          onChanged: (value, label) {
            duration = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Duration Information
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: infoColor.withAlpha(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: infoColor, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "Duration Guidelines",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "• Acute symptoms: Less than 3 days\n"
                "• Sub-acute symptoms: 3 days to 3 weeks\n"
                "• Chronic symptoms: More than 3 weeks\n"
                "• Persistent symptoms may require medical attention",
                style: TextStyle(
                  fontSize: 12,
                  color: infoColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(30)),
          ),
          child: Row(
            children: [
              Icon(Icons.edit_note, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Any additional information?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Provide any other relevant details about your symptoms",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: spMd),

        QMemoField(
          label: "Additional Information (Optional)",
          value: additionalInfo,
          hint: "Describe any triggers, patterns, or other relevant details...",
          onChanged: (value) {
            additionalInfo = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Summary of Input
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Summary of Your Input",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              _buildSummaryItem("Symptoms", selectedSymptoms.join(", ")),
              _buildSummaryItem("Body Part", selectedBodyPart),
              _buildSummaryItem("Pain Level", "$painLevel/5"),
              _buildSummaryItem("Duration", duration),
              if (additionalInfo.isNotEmpty)
                _buildSummaryItem("Additional Info", additionalInfo),
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Disclaimer
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: warningColor.withAlpha(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber, color: warningColor, size: 20),
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
              SizedBox(height: spSm),
              Text(
                "This symptom checker is for informational purposes only and should not replace professional medical advice. Always consult with a healthcare provider for proper diagnosis and treatment.",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    if (value.isEmpty) return SizedBox.shrink();
    
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPainColor(int level) {
    switch (level) {
      case 1:
        return Color(0xFF4CAF50);
      case 2:
        return Color(0xFF8BC34A);
      case 3:
        return Color(0xFFFF9800);
      case 4:
        return Color(0xFFF44336);
      case 5:
        return Color(0xFF9C27B0);
      default:
        return disabledBoldColor;
    }
  }

  void _showResults() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(radiusLg),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "Symptom Assessment Results",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),

                // Suggestions
                ...suggestions.map((suggestion) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: Color(suggestion["color"] as int).withAlpha(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Color(suggestion["color"] as int).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.health_and_safety,
                                size: 20,
                                color: Color(suggestion["color"] as int),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${suggestion["condition"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Color(suggestion["color"] as int).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${suggestion["probability"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(suggestion["color"] as int),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${suggestion["description"]}",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Recommendations:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...(suggestion["recommendations"] as List).map((rec) {
                          return Padding(
                            padding: EdgeInsets.only(left: spSm, top: spXs),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("• ", style: TextStyle(fontSize: 14)),
                                Expanded(
                                  child: Text(
                                    "$rec",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: warningColor.withAlpha(30)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.warning_amber, size: 16, color: warningColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${suggestion["warning"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
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

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Book Appointment",
                        size: bs.md,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Save Results",
                        size: bs.md,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHealthAssessmentView extends StatefulWidget {
  const MhaHealthAssessmentView({super.key});

  @override
  State<MhaHealthAssessmentView> createState() => _MhaHealthAssessmentViewState();
}

class _MhaHealthAssessmentViewState extends State<MhaHealthAssessmentView> {
  int currentQuestionIndex = 0;
  Map<int, dynamic> answers = {};
  String selectedAssessmentType = "general";

  List<Map<String, dynamic>> assessmentTypes = [
    {
      "id": "general",
      "title": "General Health Assessment",
      "description": "Comprehensive health evaluation",
      "duration": "10-15 minutes",
      "questions": 25,
      "icon": Icons.health_and_safety,
      "color": 0xFF4CAF50,
    },
    {
      "id": "mental",
      "title": "Mental Health Screening",
      "description": "Assess your mental wellbeing",
      "duration": "8-12 minutes",
      "questions": 20,
      "icon": Icons.psychology,
      "color": 0xFF9C27B0,
    },
    {
      "id": "heart",
      "title": "Cardiovascular Risk Assessment",
      "description": "Evaluate heart health factors",
      "duration": "5-8 minutes",
      "questions": 15,
      "icon": Icons.favorite,
      "color": 0xFFE91E63,
    },
    {
      "id": "diabetes",
      "title": "Diabetes Risk Assessment",
      "description": "Check your diabetes risk factors",
      "duration": "6-10 minutes",
      "questions": 18,
      "icon": Icons.water_drop,
      "color": 0xFF2196F3,
    },
  ];

  List<Map<String, dynamic>> questions = [
    {
      "id": 1,
      "question": "How would you rate your overall health?",
      "type": "rating",
      "options": ["Excellent", "Very Good", "Good", "Fair", "Poor"],
      "required": true,
    },
    {
      "id": 2,
      "question": "How many days per week do you exercise?",
      "type": "number",
      "min": 0,
      "max": 7,
      "required": true,
    },
    {
      "id": 3,
      "question": "Do you have any chronic medical conditions?",
      "type": "multiple_choice",
      "options": [
        "None",
        "Diabetes",
        "High Blood Pressure",
        "Heart Disease",
        "Asthma",
        "Arthritis",
        "Other"
      ],
      "multiple": true,
      "required": true,
    },
    {
      "id": 4,
      "question": "How many hours of sleep do you get per night?",
      "type": "slider",
      "min": 0,
      "max": 12,
      "value": 8,
      "required": true,
    },
    {
      "id": 5,
      "question": "Do you smoke or use tobacco products?",
      "type": "boolean",
      "required": true,
    },
    {
      "id": 6,
      "question": "How often do you drink alcohol?",
      "type": "single_choice",
      "options": [
        "Never",
        "Rarely (1-2 times per month)",
        "Occasionally (1-2 times per week)",
        "Regularly (3-4 times per week)",
        "Daily"
      ],
      "required": true,
    },
    {
      "id": 7,
      "question": "What is your stress level on a typical day?",
      "type": "rating",
      "options": ["Very Low", "Low", "Moderate", "High", "Very High"],
      "required": true,
    },
    {
      "id": 8,
      "question": "Do you have a family history of any of these conditions?",
      "type": "multiple_choice",
      "options": [
        "None",
        "Heart Disease",
        "Diabetes",
        "Cancer",
        "Stroke",
        "Mental Health Issues",
        "Other"
      ],
      "multiple": true,
      "required": false,
    },
  ];

  Map<String, dynamic> get currentQuestion {
    if (currentQuestionIndex < questions.length) {
      return questions[currentQuestionIndex];
    }
    return {};
  }

  double get progress {
    return (currentQuestionIndex + 1) / questions.length;
  }

  bool get isLastQuestion {
    return currentQuestionIndex >= questions.length - 1;
  }

  bool get canProceed {
    Map<String, dynamic> question = currentQuestion;
    if (question.isEmpty) return false;
    
    bool isRequired = question["required"] ?? false;
    bool hasAnswer = answers.containsKey(question["id"]);
    
    return !isRequired || hasAnswer;
  }

  @override
  Widget build(BuildContext context) {
    if (selectedAssessmentType.isEmpty || currentQuestionIndex < 0) {
      return _buildAssessmentTypeSelection();
    }

    if (currentQuestionIndex >= questions.length) {
      return _buildResultsView();
    }

    return _buildQuestionView();
  }

  Widget _buildAssessmentTypeSelection() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Assessment"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.assignment,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Choose Your Assessment",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Select the type of health assessment you'd like to complete",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Assessment Types
            Text(
              "Available Assessments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...assessmentTypes.map((assessment) => _buildAssessmentTypeCard(assessment)),

            // Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Important Information",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• These assessments are for informational purposes only\n• Results do not replace professional medical advice\n• Please consult your doctor for proper diagnosis\n• All answers are confidential and secure",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
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

  Widget _buildAssessmentTypeCard(Map<String, dynamic> assessment) {
    return GestureDetector(
      onTap: () {
        selectedAssessmentType = assessment["id"];
        currentQuestionIndex = 0;
        answers.clear();
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: disabledOutlineBorderColor),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Color(assessment["color"] as int).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Icon(
                assessment["icon"] as IconData,
                color: Color(assessment["color"] as int),
                size: 32,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "${assessment["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${assessment["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${assessment["duration"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.quiz,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${assessment["questions"]} questions",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionView() {
    Map<String, dynamic> question = currentQuestion;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Assessment"),
        actions: [
          TextButton(
            onPressed: () {
              selectedAssessmentType = "";
              setState(() {});
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: dangerColor),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Question ${currentQuestionIndex + 1} of ${questions.length}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${(progress * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),

          // Question Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spLg,
                children: [
                  Text(
                    "${question["question"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  if (question["required"] == true)
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: dangerColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Required",
                          style: TextStyle(
                            color: dangerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                  _buildQuestionInput(question),
                ],
              ),
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
                if (currentQuestionIndex > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      icon: Icons.arrow_back,
                      size: bs.md,
                      onPressed: () {
                        currentQuestionIndex--;
                        setState(() {});
                      },
                    ),
                  ),
                if (currentQuestionIndex > 0) SizedBox(width: spMd),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: isLastQuestion ? "Complete Assessment" : "Next",
                    icon: isLastQuestion ? Icons.check : Icons.arrow_forward,
                    size: bs.md,
                    onPressed: canProceed ? () {
                      if (isLastQuestion) {
                        currentQuestionIndex = questions.length;
                      } else {
                        currentQuestionIndex++;
                      }
                      setState(() {});
                    } : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionInput(Map<String, dynamic> question) {
    String type = question["type"];
    int questionId = question["id"];

    switch (type) {
      case "rating":
        return _buildRatingInput(question, questionId);
      case "number":
        return _buildNumberInput(question, questionId);
      case "boolean":
        return _buildBooleanInput(question, questionId);
      case "single_choice":
        return _buildSingleChoiceInput(question, questionId);
      case "multiple_choice":
        return _buildMultipleChoiceInput(question, questionId);
      case "slider":
        return _buildSliderInput(question, questionId);
      default:
        return Container();
    }
  }

  Widget _buildRatingInput(Map<String, dynamic> question, int questionId) {
    List<String> options = List<String>.from(question["options"]);
    String? selectedValue = answers[questionId];

    return Column(
      spacing: spSm,
      children: options.map((option) {
        bool isSelected = selectedValue == option;
        return GestureDetector(
          onTap: () {
            answers[questionId] = option;
            setState(() {});
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? primaryColor : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        )
                      : null,
                ),
                SizedBox(width: spMd),
                Text(
                  option,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? primaryColor : disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNumberInput(Map<String, dynamic> question, int questionId) {
    String value = answers[questionId]?.toString() ?? "";
    
    return QNumberField(
      label: "Enter number (${question["min"]}-${question["max"]})",
      value: value,
      hint: "Enter a number between ${question["min"]} and ${question["max"]}",
      onChanged: (value) {
        int? numValue = int.tryParse(value);
        if (numValue != null) {
          answers[questionId] = numValue;
          setState(() {});
        }
      },
    );
  }

  Widget _buildBooleanInput(Map<String, dynamic> question, int questionId) {
    bool? selectedValue = answers[questionId];

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              answers[questionId] = true;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: selectedValue == true ? successColor.withAlpha(20) : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: selectedValue == true ? successColor : disabledOutlineBorderColor,
                  width: selectedValue == true ? 2 : 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: selectedValue == true ? successColor : disabledBoldColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Yes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: selectedValue == true ? FontWeight.w600 : FontWeight.normal,
                      color: selectedValue == true ? successColor : disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: GestureDetector(
            onTap: () {
              answers[questionId] = false;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: selectedValue == false ? dangerColor.withAlpha(20) : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: selectedValue == false ? dangerColor : disabledOutlineBorderColor,
                  width: selectedValue == false ? 2 : 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cancel,
                    color: selectedValue == false ? dangerColor : disabledBoldColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "No",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: selectedValue == false ? FontWeight.w600 : FontWeight.normal,
                      color: selectedValue == false ? dangerColor : disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleChoiceInput(Map<String, dynamic> question, int questionId) {
    List<String> options = List<String>.from(question["options"]);
    String? selectedValue = answers[questionId];

    return Column(
      spacing: spSm,
      children: options.map((option) {
        bool isSelected = selectedValue == option;
        return GestureDetector(
          onTap: () {
            answers[questionId] = option;
            setState(() {});
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? primaryColor : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        )
                      : null,
                ),
                SizedBox(width: spMd),
                Text(
                  option,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? primaryColor : disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMultipleChoiceInput(Map<String, dynamic> question, int questionId) {
    List<String> options = List<String>.from(question["options"]);
    List<String> selectedValues = List<String>.from(answers[questionId] ?? []);

    return Column(
      spacing: spSm,
      children: options.map((option) {
        bool isSelected = selectedValues.contains(option);
        return GestureDetector(
          onTap: () {
            if (isSelected) {
              selectedValues.remove(option);
            } else {
              selectedValues.add(option);
            }
            answers[questionId] = selectedValues;
            setState(() {});
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusXs),
                    color: isSelected ? primaryColor : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        )
                      : null,
                ),
                SizedBox(width: spMd),
                Text(
                  option,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? primaryColor : disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSliderInput(Map<String, dynamic> question, int questionId) {
    double value = (answers[questionId] ?? question["value"] ?? 0).toDouble();
    double min = (question["min"] ?? 0).toDouble();
    double max = (question["max"] ?? 10).toDouble();

    return Column(
      spacing: spMd,
      children: [
        Text(
          "${value.toInt()} hours",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          activeColor: primaryColor,
          inactiveColor: disabledColor,
          onChanged: (newValue) {
            answers[questionId] = newValue.toInt();
            setState(() {});
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${min.toInt()}",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
            ),
            Text(
              "${max.toInt()}",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResultsView() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assessment Results"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Success Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 48,
                  ),
                  Text(
                    "Assessment Completed!",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Your health assessment has been successfully completed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Results Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Your Health Score",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "78",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "out of 100",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Good Health",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: 0.78,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(successColor),
                  ),
                ],
              ),
            ),

            // Recommendations
            Text(
              "Recommendations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            _buildRecommendationCard(
              "Exercise More",
              "Increase physical activity to 150 minutes per week",
              Icons.fitness_center,
              warningColor,
            ),
            _buildRecommendationCard(
              "Improve Sleep",
              "Aim for 7-9 hours of quality sleep per night",
              Icons.bedtime,
              infoColor,
            ),
            _buildRecommendationCard(
              "Regular Checkups",
              "Schedule annual health checkups with your doctor",
              Icons.medical_services,
              primaryColor,
            ),

            // Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Results",
                    icon: Icons.save,
                    size: bs.md,
                    onPressed: () {
                      ss("Assessment results saved successfully");
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Share",
                    icon: Icons.share,
                    size: bs.md,
                    onPressed: () {
                      // Share results
                    },
                  ),
                ),
              ],
            ),

            QButton(
              label: "Back to Home",
              icon: Icons.home,
              size: bs.md,
              onPressed: () {
                // Navigate to home
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
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

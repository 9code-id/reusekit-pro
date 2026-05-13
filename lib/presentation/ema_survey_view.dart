import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSurveyView extends StatefulWidget {
  const EmaSurveyView({super.key});

  @override
  State<EmaSurveyView> createState() => _EmaSurveyViewState();
}

class _EmaSurveyViewState extends State<EmaSurveyView> {
  int currentQuestion = 0;
  Map<int, dynamic> responses = {};
  bool isSubmitting = false;

  List<Map<String, dynamic>> surveyQuestions = [
    {
      "id": 1,
      "question": "How are you feeling right now?",
      "type": "scale",
      "options": ["Very Bad", "Bad", "Neutral", "Good", "Very Good"],
      "required": true,
    },
    {
      "id": 2,
      "question": "What is your current stress level?",
      "type": "scale",
      "options": ["None", "Low", "Moderate", "High", "Very High"],
      "required": true,
    },
    {
      "id": 3,
      "question": "How many hours did you sleep last night?",
      "type": "number",
      "min": 0,
      "max": 24,
      "required": true,
    },
    {
      "id": 4,
      "question": "What activities have you done today?",
      "type": "multiple",
      "options": ["Exercise", "Work", "Socializing", "Leisure", "Study", "Rest"],
      "required": false,
    },
    {
      "id": 5,
      "question": "Any additional notes about your day?",
      "type": "text",
      "required": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMA Survey"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              si("Complete the survey to track your daily experiences");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timeline,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Question ${currentQuestion + 1} of ${surveyQuestions.length}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${(((currentQuestion + 1) / surveyQuestions.length) * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Progress bar
            LinearProgressIndicator(
              value: (currentQuestion + 1) / surveyQuestions.length,
              backgroundColor: disabledColor,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
            SizedBox(height: spLg),

            // Current question
            _buildQuestionCard(),
            SizedBox(height: spLg),

            // Navigation buttons
            Row(
              children: [
                if (currentQuestion > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: () {
                        setState(() {
                          currentQuestion--;
                        });
                      },
                    ),
                  ),
                if (currentQuestion > 0) SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: currentQuestion < surveyQuestions.length - 1 ? "Next" : "Submit Survey",
                    size: bs.md,
                    onPressed: _handleNext,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard() {
    final question = surveyQuestions[currentQuestion];
    
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Center(
                  child: Text(
                    "${question["id"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${question["question"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (question["required"] == true)
                      Text(
                        "Required",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildQuestionInput(question),
        ],
      ),
    );
  }

  Widget _buildQuestionInput(Map<String, dynamic> question) {
    switch (question["type"]) {
      case "scale":
        return _buildScaleInput(question);
      case "number":
        return _buildNumberInput(question);
      case "multiple":
        return _buildMultipleChoice(question);
      case "text":
        return _buildTextInput(question);
      default:
        return Container();
    }
  }

  Widget _buildScaleInput(Map<String, dynamic> question) {
    final options = question["options"] as List<String>;
    final selectedValue = responses[question["id"]];

    return Column(
      children: List.generate(options.length, (index) {
        final option = options[index];
        final isSelected = selectedValue == index;

        return Container(
          margin: EdgeInsets.only(bottom: spXs),
          child: GestureDetector(
            onTap: () {
              setState(() {
                responses[question["id"]] = index;
              });
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
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
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 12,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    option,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNumberInput(Map<String, dynamic> question) {
    return QNumberField(
      label: "Enter number",
      value: responses[question["id"]]?.toString() ?? "",
      hint: "Enter a value between ${question["min"]} and ${question["max"]}",
      onChanged: (value) {
        responses[question["id"]] = double.tryParse(value) ?? 0;
        setState(() {});
      },
    );
  }

  Widget _buildMultipleChoice(Map<String, dynamic> question) {
    final options = question["options"] as List<String>;
    final selectedValues = responses[question["id"]] as List<String>? ?? [];

    return Column(
      children: List.generate(options.length, (index) {
        final option = options[index];
        final isSelected = selectedValues.contains(option);

        return Container(
          margin: EdgeInsets.only(bottom: spXs),
          child: GestureDetector(
            onTap: () {
              setState(() {
                List<String> currentValues = List<String>.from(selectedValues);
                if (isSelected) {
                  currentValues.remove(option);
                } else {
                  currentValues.add(option);
                }
                responses[question["id"]] = currentValues;
              });
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
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
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 12,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    option,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTextInput(Map<String, dynamic> question) {
    return QMemoField(
      label: "Your notes",
      value: responses[question["id"]]?.toString() ?? "",
      hint: "Share any additional thoughts or observations",
      onChanged: (value) {
        responses[question["id"]] = value;
        setState(() {});
      },
    );
  }

  void _handleNext() {
    final question = surveyQuestions[currentQuestion];
    
    // Validate required questions
    if (question["required"] == true && responses[question["id"]] == null) {
      se("Please answer this question before continuing");
      return;
    }

    if (currentQuestion < surveyQuestions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      _submitSurvey();
    }
  }

  void _submitSurvey() async {
    setState(() {
      isSubmitting = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isSubmitting = false;
    });

    ss("Survey submitted successfully!");
    back();
  }
}

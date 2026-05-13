import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTutorial5View extends StatefulWidget {
  @override
  State<GrlTutorial5View> createState() => _GrlTutorial5ViewState();
}

class _GrlTutorial5ViewState extends State<GrlTutorial5View> {
  int currentQuestionIndex = 0;
  List<String> selectedAnswers = [];
  bool isCompleted = false;

  List<Map<String, dynamic>> tutorialQuestions = [
    {
      "question": "What would you like to accomplish with our platform?",
      "type": "single",
      "options": [
        {"value": "business_growth", "label": "Grow my business", "icon": Icons.trending_up},
        {"value": "productivity", "label": "Increase productivity", "icon": Icons.speed},
        {"value": "collaboration", "label": "Improve team collaboration", "icon": Icons.groups},
        {"value": "automation", "label": "Automate workflows", "icon": Icons.auto_awesome},
        {"value": "analytics", "label": "Better data insights", "icon": Icons.analytics},
      ],
    },
    {
      "question": "What's your current experience level?",
      "type": "single",
      "options": [
        {"value": "beginner", "label": "Complete beginner", "icon": Icons.school},
        {"value": "some_experience", "label": "Some experience", "icon": Icons.psychology},
        {"value": "experienced", "label": "Very experienced", "icon": Icons.star},
        {"value": "expert", "label": "Expert level", "icon": Icons.emoji_events},
      ],
    },
    {
      "question": "Which features interest you most? (Select all that apply)",
      "type": "multiple",
      "options": [
        {"value": "dashboard", "label": "Custom Dashboard", "icon": Icons.dashboard},
        {"value": "reports", "label": "Advanced Reports", "icon": Icons.assessment},
        {"value": "integrations", "label": "Third-party Integrations", "icon": Icons.extension},
        {"value": "mobile", "label": "Mobile Access", "icon": Icons.phone_android},
        {"value": "api", "label": "API Access", "icon": Icons.code},
        {"value": "support", "label": "24/7 Support", "icon": Icons.support_agent},
      ],
    },
    {
      "question": "How large is your team?",
      "type": "single",
      "options": [
        {"value": "solo", "label": "Just me", "icon": Icons.person},
        {"value": "small", "label": "2-10 people", "icon": Icons.group},
        {"value": "medium", "label": "11-50 people", "icon": Icons.groups},
        {"value": "large", "label": "50+ people", "icon": Icons.corporate_fare},
      ],
    },
    {
      "question": "What's most important to you?",
      "type": "single",
      "options": [
        {"value": "ease_of_use", "label": "Easy to use interface", "icon": Icons.touch_app},
        {"value": "powerful_features", "label": "Powerful features", "icon": Icons.rocket_launch},
        {"value": "fast_performance", "label": "Fast performance", "icon": Icons.flash_on},
        {"value": "great_support", "label": "Excellent support", "icon": Icons.support},
        {"value": "affordable_price", "label": "Affordable pricing", "icon": Icons.attach_money},
      ],
    },
  ];

  void _nextQuestion() {
    if (currentQuestionIndex < tutorialQuestions.length - 1) {
      currentQuestionIndex++;
      setState(() {});
    } else {
      _completeTutorial();
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      setState(() {});
    }
  }

  void _selectAnswer(String value, bool isMultiple) {
    if (isMultiple) {
      if (selectedAnswers.contains(value)) {
        selectedAnswers.remove(value);
      } else {
        selectedAnswers.add(value);
      }
    } else {
      selectedAnswers.clear();
      selectedAnswers.add(value);
    }
    setState(() {});
  }

  void _completeTutorial() {
    isCompleted = true;
    setState(() {});
    ss("Tutorial completed! Personalizing your experience...");
  }

  bool _hasSelectedAnswer() {
    return selectedAnswers.isNotEmpty;
  }

  void _skipQuestion() {
    selectedAnswers.clear();
    _nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return _buildCompletionScreen();
    }

    final question = tutorialQuestions[currentQuestionIndex];
    final isMultiple = question["type"] == "multiple";
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Personalize Your Experience"),
        actions: [
          TextButton(
            onPressed: _skipQuestion,
            child: Text(
              "Skip",
              style: TextStyle(
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Question ${currentQuestionIndex + 1} of ${tutorialQuestions.length}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${((currentQuestionIndex + 1) / tutorialQuestions.length * 100).toInt()}% Complete",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / tutorialQuestions.length,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Question
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor.withAlpha(30),
                          primaryColor.withAlpha(10),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.quiz,
                          size: 48,
                          color: primaryColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${question["question"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (isMultiple) ...[
                          SizedBox(height: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spMd,
                              vertical: spSm,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "Select all that apply",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Options
                  ...(question["options"] as List<Map<String, dynamic>>)
                      .map((option) {
                    final isSelected = selectedAnswers.contains(option["value"]);
                    
                    return GestureDetector(
                      onTap: () => _selectAnswer(option["value"], isMultiple),
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? primaryColor.withAlpha(20) 
                              : Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledColor,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: isSelected ? [shadowSm] : [],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? primaryColor.withAlpha(30)
                                    : disabledColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                option["icon"] as IconData,
                                color: isSelected ? primaryColor : disabledBoldColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Text(
                                "${option["label"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                isMultiple ? Icons.check_box : Icons.radio_button_checked,
                                color: primaryColor,
                                size: 24,
                              )
                            else
                              Icon(
                                isMultiple ? Icons.check_box_outline_blank : Icons.radio_button_unchecked,
                                color: disabledColor,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    );
                  }),

                  // Tips
                  if (currentQuestionIndex == 0)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "This helps us customize your dashboard and recommend relevant features for your needs.",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Navigation
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
                      size: bs.md,
                      icon: Icons.arrow_back,
                      onPressed: _previousQuestion,
                    ),
                  ),
                if (currentQuestionIndex > 0) SizedBox(width: spMd),
                Expanded(
                  flex: currentQuestionIndex == 0 ? 1 : 1,
                  child: QButton(
                    label: currentQuestionIndex == tutorialQuestions.length - 1 
                        ? "Complete Setup" 
                        : "Next",
                    size: bs.md,
                    icon: currentQuestionIndex == tutorialQuestions.length - 1 
                        ? Icons.check 
                        : Icons.arrow_forward,
                    onPressed: _hasSelectedAnswer() ? _nextQuestion : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionScreen() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 80,
                color: successColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Perfect!",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Your experience is now personalized",
              style: TextStyle(
                fontSize: fsH5,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Based on your preferences, we've customized your dashboard and enabled relevant features. You can always change these settings later in your preferences.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: spLg),

            // Summary cards
            ...["Dashboard customized", "Features enabled", "Notifications configured"]
                .map((item) => Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            item,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    )),

            SizedBox(height: spLg),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue to Dashboard",
                size: bs.md,
                icon: Icons.dashboard,
                onPressed: () {
                  ss("Welcome to your personalized dashboard!");
                  // Navigate to main app
                },
              ),
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Explore Features",
                size: bs.md,
                icon: Icons.explore,
                onPressed: () {
                  si("Opening feature tour");
                  // Navigate to feature tour
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

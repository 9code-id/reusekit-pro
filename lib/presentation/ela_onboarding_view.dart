import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaOnboardingView extends StatefulWidget {
  const ElaOnboardingView({super.key});

  @override
  State<ElaOnboardingView> createState() => _ElaOnboardingViewState();
}

class _ElaOnboardingViewState extends State<ElaOnboardingView> {
  int currentStep = 0;
  String selectedRole = "";
  String experienceLevel = "";
  List<String> selectedInterests = [];
  String learningGoal = "";
  String preferredLanguage = "english";
  bool receiveNotifications = true;
  bool shareAnalytics = false;

  List<Map<String, dynamic>> roles = [
    {
      "id": "student",
      "title": "Student",
      "description": "I'm here to learn new skills",
      "icon": Icons.school,
      "color": primaryColor
    },
    {
      "id": "professional",
      "title": "Professional",
      "description": "I want to advance my career",
      "icon": Icons.work,
      "color": successColor
    },
    {
      "id": "teacher",
      "title": "Teacher/Educator",
      "description": "I want to teach or create content",
      "icon": Icons.person_4,
      "color": warningColor
    },
    {
      "id": "hobbyist",
      "title": "Hobbyist",
      "description": "Learning for personal interest",
      "icon": Icons.favorite,
      "color": dangerColor
    }
  ];

  List<Map<String, dynamic>> experienceLevels = [
    {
      "id": "beginner",
      "title": "Beginner",
      "description": "I'm new to online learning",
      "icon": Icons.star_border
    },
    {
      "id": "intermediate",
      "title": "Intermediate",
      "description": "I have some experience",
      "icon": Icons.star_half
    },
    {
      "id": "advanced",
      "title": "Advanced",
      "description": "I'm experienced and looking to specialize",
      "icon": Icons.star
    }
  ];

  List<Map<String, dynamic>> interests = [
    {"id": "technology", "title": "Technology", "icon": Icons.computer, "selected": false},
    {"id": "business", "title": "Business", "icon": Icons.business, "selected": false},
    {"id": "design", "title": "Design", "icon": Icons.palette, "selected": false},
    {"id": "marketing", "title": "Marketing", "icon": Icons.campaign, "selected": false},
    {"id": "languages", "title": "Languages", "icon": Icons.language, "selected": false},
    {"id": "health", "title": "Health & Fitness", "icon": Icons.health_and_safety, "selected": false},
    {"id": "arts", "title": "Arts & Crafts", "icon": Icons.brush, "selected": false},
    {"id": "science", "title": "Science", "icon": Icons.science, "selected": false},
    {"id": "music", "title": "Music", "icon": Icons.music_note, "selected": false},
    {"id": "cooking", "title": "Cooking", "icon": Icons.restaurant, "selected": false}
  ];

  List<Map<String, dynamic>> learningGoals = [
    {
      "id": "career_change",
      "title": "Career Change",
      "description": "Switch to a new field or industry"
    },
    {
      "id": "skill_upgrade",
      "title": "Skill Upgrade",
      "description": "Improve my current job skills"
    },
    {
      "id": "certification",
      "title": "Get Certified",
      "description": "Earn certificates or credentials"
    },
    {
      "id": "personal_growth",
      "title": "Personal Growth",
      "description": "Learn for personal satisfaction"
    },
    {
      "id": "hobby",
      "title": "New Hobby",
      "description": "Explore new interests and hobbies"
    }
  ];

  List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
    {"label": "Chinese", "value": "chinese"},
    {"label": "Japanese", "value": "japanese"},
    {"label": "Portuguese", "value": "portuguese"},
    {"label": "Arabic", "value": "arabic"}
  ];

  void _toggleInterest(String interestId) {
    if (selectedInterests.contains(interestId)) {
      selectedInterests.remove(interestId);
    } else {
      selectedInterests.add(interestId);
    }
    setState(() {});
  }

  void _nextStep() {
    if (currentStep < 5) {
      currentStep++;
      setState(() {});
    } else {
      _completeOnboarding();
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _completeOnboarding() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Welcome to EduLearn Academy! Your profile has been set up successfully.");
    // Navigate to home
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedRole.isNotEmpty;
      case 1:
        return experienceLevel.isNotEmpty;
      case 2:
        return selectedInterests.isNotEmpty;
      case 3:
        return learningGoal.isNotEmpty;
      case 4:
        return preferredLanguage.isNotEmpty;
      case 5:
        return true;
      default:
        return false;
    }
  }

  Widget _buildStep0() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "What brings you here?",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Tell us about your role so we can personalize your experience",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
        ...roles.map((role) {
          bool isSelected = selectedRole == role["id"];
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                width: isSelected ? 2 : 1,
              ),
              color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
            ),
            child: InkWell(
              onTap: () {
                selectedRole = "${role["id"]}";
                setState(() {});
              },
              borderRadius: BorderRadius.circular(radiusMd),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (role["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        role["icon"] as IconData,
                        color: role["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${role["title"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${role["description"]}",
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
                        color: primaryColor,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildStep1() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "What's your experience level?",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "This helps us recommend the right courses for you",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
        ...experienceLevels.map((level) {
          bool isSelected = experienceLevel == level["id"];
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: isSelected ? successColor : disabledOutlineBorderColor,
                width: isSelected ? 2 : 1,
              ),
              color: isSelected ? successColor.withAlpha(10) : Colors.white,
            ),
            child: InkWell(
              onTap: () {
                experienceLevel = "${level["id"]}";
                setState(() {});
              },
              borderRadius: BorderRadius.circular(radiusMd),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        level["icon"] as IconData,
                        color: successColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${level["title"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${level["description"]}",
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
                        color: successColor,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "What interests you?",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Select the topics you'd like to learn about (choose multiple)",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: interests.map((interest) {
            bool isSelected = selectedInterests.contains("${interest["id"]}");
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isSelected ? warningColor : disabledOutlineBorderColor,
                  width: isSelected ? 2 : 1,
                ),
                color: isSelected ? warningColor.withAlpha(10) : Colors.white,
              ),
              child: InkWell(
                onTap: () => _toggleInterest("${interest["id"]}"),
                borderRadius: BorderRadius.circular(radiusMd),
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          interest["icon"] as IconData,
                          color: warningColor,
                          size: 24,
                        ),
                      ),
                      Text(
                        "${interest["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: warningColor,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "What's your learning goal?",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "This helps us suggest the most relevant learning paths",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
        ...learningGoals.map((goal) {
          bool isSelected = learningGoal == goal["id"];
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: isSelected ? infoColor : disabledOutlineBorderColor,
                width: isSelected ? 2 : 1,
              ),
              color: isSelected ? infoColor.withAlpha(10) : Colors.white,
            ),
            child: InkWell(
              onTap: () {
                learningGoal = "${goal["id"]}";
                setState(() {});
              },
              borderRadius: BorderRadius.circular(radiusMd),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${goal["title"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${goal["description"]}",
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
                        color: infoColor,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "Choose your preferences",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Set up your learning environment",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Preferred Language",
                items: languages,
                value: preferredLanguage,
                onChanged: (value, label) {
                  preferredLanguage = value;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Receive learning reminders and notifications",
                    "value": "notifications",
                    "checked": receiveNotifications,
                  },
                  {
                    "label": "Share anonymous usage data to improve experience",
                    "value": "analytics",
                    "checked": shareAnalytics,
                  }
                ],
                value: [
                  if (receiveNotifications)
                    {"label": "Receive learning reminders and notifications", "value": "notifications", "checked": true},
                  if (shareAnalytics)
                    {"label": "Share anonymous usage data to improve experience", "value": "analytics", "checked": true},
                ],
                onChanged: (values, ids) {
                  receiveNotifications = values.any((v) => v["value"] == "notifications");
                  shareAnalytics = values.any((v) => v["value"] == "analytics");
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep5() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Icon(
            Icons.check_circle,
            color: successColor,
            size: 60,
          ),
        ),
        Text(
          "You're all set!",
          style: TextStyle(
            fontSize: fsH3,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Your personalized learning experience is ready. Let's start your journey!",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              Text(
                "Your Profile Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Text("Role:", style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: spSm),
                  Text(selectedRole.replaceAll('_', ' ').toUpperCase()),
                ],
              ),
              Row(
                children: [
                  Text("Experience:", style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: spSm),
                  Text(experienceLevel.replaceAll('_', ' ').toUpperCase()),
                ],
              ),
              Row(
                children: [
                  Text("Interests:", style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: spSm),
                  Text("${selectedInterests.length} selected"),
                ],
              ),
              Row(
                children: [
                  Text("Goal:", style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: spSm),
                  Text(learningGoal.replaceAll('_', ' ').toUpperCase()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "EduLearn Academy",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${currentStep + 1}/6",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: (currentStep + 1) / 6,
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
                child: Builder(
                  builder: (context) {
                    switch (currentStep) {
                      case 0:
                        return _buildStep0();
                      case 1:
                        return _buildStep1();
                      case 2:
                        return _buildStep2();
                      case 3:
                        return _buildStep3();
                      case 4:
                        return _buildStep4();
                      case 5:
                        return _buildStep5();
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            ),
            
            // Navigation Buttons
            Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: QButton(
                        label: "Back",
                        onPressed: _previousStep,
                      ),
                    ),
                  if (currentStep > 0) SizedBox(width: spMd),
                  Expanded(
                    flex: currentStep == 0 ? 1 : 2,
                    child: QButton(
                      label: currentStep == 5 ? "Get Started" : "Continue",
                      onPressed: _canProceed() ? _nextStep : null,
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
}

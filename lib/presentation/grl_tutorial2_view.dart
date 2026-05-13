import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTutorial2View extends StatefulWidget {
  @override
  State<GrlTutorial2View> createState() => _GrlTutorial2ViewState();
}

class _GrlTutorial2ViewState extends State<GrlTutorial2View> {
  int currentStep = 0;
  bool isCompleted = false;

  List<Map<String, dynamic>> tutorialSteps = [
    {
      "title": "Create Your Profile",
      "description": "Set up your personal profile with your basic information",
      "icon": Icons.person_add,
      "color": primaryColor,
      "details": [
        "Add your profile photo",
        "Enter your name and contact details",
        "Set your preferences and interests",
        "Choose your privacy settings",
      ],
      "tips": "A complete profile helps others connect with you better",
      "estimatedTime": "3 minutes",
    },
    {
      "title": "Connect Your Accounts",
      "description": "Link your social media and professional accounts for better integration",
      "icon": Icons.link,
      "color": infoColor,
      "details": [
        "Connect your LinkedIn profile",
        "Link your Twitter account",
        "Add your GitHub or portfolio",
        "Sync your calendar (optional)",
      ],
      "tips": "Connecting accounts enables automatic updates and seamless sharing",
      "estimatedTime": "5 minutes",
    },
    {
      "title": "Customize Your Dashboard",
      "description": "Personalize your dashboard layout and widgets",
      "icon": Icons.dashboard_customize,
      "color": successColor,
      "details": [
        "Choose your preferred layout",
        "Add relevant widgets",
        "Set up quick actions",
        "Configure notifications",
      ],
      "tips": "A personalized dashboard improves your daily workflow efficiency",
      "estimatedTime": "4 minutes",
    },
    {
      "title": "Explore Core Features",
      "description": "Discover the main features and tools available to you",
      "icon": Icons.explore,
      "color": warningColor,
      "details": [
        "Browse the feature library",
        "Try interactive demos",
        "Access help documentation",
        "Join community discussions",
      ],
      "tips": "Take your time to explore - there's a lot to discover!",
      "estimatedTime": "10 minutes",
    },
    {
      "title": "Set Up Integrations",
      "description": "Connect with third-party tools and services you use",
      "icon": Icons.integration_instructions,
      "color": primaryColor,
      "details": [
        "Browse available integrations",
        "Configure API connections",
        "Set up automation rules",
        "Test your integrations",
      ],
      "tips": "Integrations can save you hours of manual work each week",
      "estimatedTime": "8 minutes",
    },
    {
      "title": "Complete Your Setup",
      "description": "Finalize your account setup and start using the platform",
      "icon": Icons.check_circle,
      "color": successColor,
      "details": [
        "Review your settings",
        "Complete verification steps",
        "Set up billing (if applicable)",
        "Take the guided tour",
      ],
      "tips": "You're almost ready to enjoy the full experience!",
      "estimatedTime": "5 minutes",
    },
  ];

  void _nextStep() {
    if (currentStep < tutorialSteps.length - 1) {
      currentStep++;
      setState(() {});
    } else {
      isCompleted = true;
      setState(() {});
      ss("Tutorial completed successfully!");
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _skipTutorial() async {
    bool isConfirmed = await confirm("Are you sure you want to skip this tutorial?");
    if (isConfirmed) {
      si("Tutorial skipped. You can access it anytime from settings.");
      // Navigate back or to main screen
    }
  }

  double get progressPercentage => (currentStep + 1) / tutorialSteps.length;

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return _buildCompletionScreen();
    }

    final step = tutorialSteps[currentStep];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Getting Started"),
        actions: [
          TextButton(
            onPressed: _skipTutorial,
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
          // Progress Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Step ${currentStep + 1} of ${tutorialSteps.length}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${(progressPercentage * 100).toInt()}% Complete",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: progressPercentage,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(step["color"] as Color),
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
                  // Step Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (step["color"] as Color).withAlpha(30),
                          (step["color"] as Color).withAlpha(10),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: (step["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXl),
                          ),
                          child: Icon(
                            step["icon"] as IconData,
                            size: 48,
                            color: step["color"] as Color,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${step["title"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: step["color"] as Color,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${step["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Time Estimate
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: (step["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: (step["color"] as Color).withAlpha(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: step["color"] as Color,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Estimated time: ${step["estimatedTime"]}",
                          style: TextStyle(
                            color: step["color"] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Step Details
                  Text(
                    "What you'll do:",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ...(step["details"] as List<String>).asMap().entries.map((entry) {
                    final index = entry.key;
                    final detail = entry.value;
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: (step["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXl),
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color: step["color"] as Color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Text(
                              detail,
                              style: TextStyle(
                                color: disabledBoldColor,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  // Tips Section
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Pro Tip",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${step["tips"]}",
                          style: TextStyle(
                            color: successColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                if (currentStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      icon: Icons.arrow_back,
                      onPressed: _previousStep,
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spMd),
                Expanded(
                  flex: currentStep == 0 ? 1 : 1,
                  child: QButton(
                    label: currentStep == tutorialSteps.length - 1 ? "Complete" : "Next",
                    size: bs.md,
                    icon: currentStep == tutorialSteps.length - 1 
                        ? Icons.check 
                        : Icons.arrow_forward,
                    onPressed: _nextStep,
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
                Icons.celebration,
                size: 80,
                color: successColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Congratulations!",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "You've completed the tutorial",
              style: TextStyle(
                fontSize: fsH5,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "You're now ready to explore all the amazing features and make the most of your experience with our platform.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: spLg),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start Exploring",
                size: bs.md,
                icon: Icons.rocket_launch,
                onPressed: () {
                  ss("Welcome to the platform!");
                  // Navigate to main screen
                },
              ),
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Review Tutorial Again",
                size: bs.md,
                icon: Icons.replay,
                onPressed: () {
                  currentStep = 0;
                  isCompleted = false;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

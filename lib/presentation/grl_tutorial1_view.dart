import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTutorial1View extends StatefulWidget {
  const GrlTutorial1View({super.key});

  @override
  State<GrlTutorial1View> createState() => _GrlTutorial1ViewState();
}

class _GrlTutorial1ViewState extends State<GrlTutorial1View> {
  int currentStep = 0;
  
  final List<Map<String, dynamic>> tutorialSteps = [
    {
      "title": "Welcome to the App",
      "description": "Let's get started with a quick tour of the main features",
      "icon": Icons.waves,
      "color": 0xFF6366F1,
      "image": "https://picsum.photos/300/200?random=1&keyword=welcome",
    },
    {
      "title": "Create Your Profile",
      "description": "Set up your personal information and preferences",
      "icon": Icons.person,
      "color": 0xFF10B981,
      "image": "https://picsum.photos/300/200?random=2&keyword=profile",
    },
    {
      "title": "Connect with Others",
      "description": "Find and connect with friends and colleagues",
      "icon": Icons.group,
      "color": 0xFFF59E0B,
      "image": "https://picsum.photos/300/200?random=3&keyword=connect",
    },
    {
      "title": "Explore Features",
      "description": "Discover all the amazing features available to you",
      "icon": Icons.explore,
      "color": 0xFFEF4444,
      "image": "https://picsum.photos/300/200?random=4&keyword=explore",
    },
    {
      "title": "You're All Set!",
      "description": "Ready to start your journey with our app",
      "icon": Icons.check_circle,
      "color": 0xFF8B5CF6,
      "image": "https://picsum.photos/300/200?random=5&keyword=success",
    },
  ];

  bool showTips = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color((tutorialSteps[currentStep]["color"] as int)).withAlpha(20),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Progress indicator
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: (currentStep + 1) / tutorialSteps.length,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color((tutorialSteps[currentStep]["color"] as int)),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${currentStep + 1} / ${tutorialSteps.length}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: [
                      // Skip button
                      if (currentStep < tutorialSteps.length - 1)
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              currentStep = tutorialSteps.length - 1;
                              setState(() {});
                            },
                            child: Text(
                              "Skip Tutorial",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                      SizedBox(height: spLg),

                      // Tutorial image
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${tutorialSteps[currentStep]["image"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: spXl),

                      // Icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color((tutorialSteps[currentStep]["color"] as int)).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXl),
                        ),
                        child: Icon(
                          tutorialSteps[currentStep]["icon"] as IconData,
                          size: 40,
                          color: Color((tutorialSteps[currentStep]["color"] as int)),
                        ),
                      ),

                      SizedBox(height: spLg),

                      // Title
                      Text(
                        "${tutorialSteps[currentStep]["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Description
                      Text(
                        "${tutorialSteps[currentStep]["description"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: spXl),

                      // Tips section
                      if (showTips)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: warningColor.withAlpha(40),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lightbulb,
                                    color: warningColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Pro Tip",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showTips = false;
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: warningColor,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Take your time to explore each feature. You can always revisit this tutorial from the settings menu.",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                      SizedBox(height: spXl),

                      // Action buttons
                      Row(
                        children: [
                          if (currentStep > 0)
                            Expanded(
                              child: QButton(
                                label: "Previous",
                                color: disabledColor,
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
                            flex: currentStep == 0 ? 1 : 1,
                            child: QButton(
                              label: currentStep == tutorialSteps.length - 1 
                                ? "Get Started" 
                                : "Next",
                              size: bs.md,
                              onPressed: () {
                                if (currentStep < tutorialSteps.length - 1) {
                                  currentStep++;
                                  setState(() {});
                                } else {
                                  ss("Tutorial completed! Welcome aboard!");
                                }
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
      ),
    );
  }
}

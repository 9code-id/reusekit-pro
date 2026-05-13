import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWelcome8View extends StatefulWidget {
  @override
  State<GrlWelcome8View> createState() => _GrlWelcome8ViewState();
}

class _GrlWelcome8ViewState extends State<GrlWelcome8View> {
  int currentTutorialStep = 0;
  
  final List<Map<String, dynamic>> tutorialSteps = [
    {
      "title": "Navigation Made Easy",
      "description": "Use the bottom navigation bar to quickly move between different sections of the app.",
      "image": "https://picsum.photos/300/200?random=1&keyword=navigation",
      "icon": Icons.navigation,
      "color": primaryColor,
    },
    {
      "title": "Smart Search",
      "description": "Find anything instantly with our powerful search feature. Just tap the search icon and start typing.",
      "image": "https://picsum.photos/300/200?random=2&keyword=search",
      "icon": Icons.search,
      "color": successColor,
    },
    {
      "title": "Personalized Dashboard",
      "description": "Your home screen shows the most relevant information based on your activity and preferences.",
      "image": "https://picsum.photos/300/200?random=3&keyword=dashboard",
      "icon": Icons.dashboard,
      "color": infoColor,
    },
    {
      "title": "Quick Actions",
      "description": "Access frequently used features with floating action buttons and quick shortcuts.",
      "image": "https://picsum.photos/300/200?random=4&keyword=actions",
      "icon": Icons.flash_on,
      "color": warningColor,
    },
    {
      "title": "Notifications Center",
      "description": "Stay updated with important notifications and never miss anything important.",
      "image": "https://picsum.photos/300/200?random=5&keyword=notifications",
      "icon": Icons.notifications,
      "color": dangerColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentStep = tutorialSteps[currentTutorialStep];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("App Tutorial"),
        actions: [
          GestureDetector(
            onTap: () {
              // navigateTo('');
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Progress Indicator
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tutorial Progress",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${currentTutorialStep + 1}/${tutorialSteps.length}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: currentStep["color"],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Progress Bar
                  Container(
                    width: double.infinity,
                    height: 8,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (currentTutorialStep + 1) / tutorialSteps.length,
                      child: Container(
                        decoration: BoxDecoration(
                          color: currentStep["color"],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Step Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(tutorialSteps.length, (index) {
                      final isActive = index == currentTutorialStep;
                      final isCompleted = index < currentTutorialStep;
                      
                      return Container(
                        width: isActive ? 12 : 8,
                        height: isActive ? 12 : 8,
                        margin: EdgeInsets.symmetric(horizontal: spXs),
                        decoration: BoxDecoration(
                          color: isCompleted 
                              ? successColor 
                              : isActive 
                                  ? currentStep["color"] 
                                  : disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Main Tutorial Content
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Feature Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: currentStep["color"].withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXl),
                    ),
                    child: Icon(
                      currentStep["icon"],
                      size: 40,
                      color: currentStep["color"],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Title
                  Text(
                    "${currentStep["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Description
                  Text(
                    "${currentStep["description"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Feature Image
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${currentStep["image"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Feature Highlights
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: currentStep["color"].withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: currentStep["color"].withAlpha(100),
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
                        color: currentStep["color"],
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Pro Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Column(
                    children: _getTipsForCurrentStep().map((tip) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                color: currentStep["color"],
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                tip,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
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
            
            SizedBox(height: sp2xl),
            
            // Navigation Buttons
            Row(
              children: [
                if (currentTutorialStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      onPressed: () {
                        if (currentTutorialStep > 0) {
                          currentTutorialStep--;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                if (currentTutorialStep > 0) SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: currentTutorialStep < tutorialSteps.length - 1 ? "Next" : "Get Started",
                    size: bs.md,
                    onPressed: () {
                      if (currentTutorialStep < tutorialSteps.length - 1) {
                        currentTutorialStep++;
                        setState(() {});
                      } else {
                        // navigateTo('');
                      }
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Skip Tutorial
            if (currentTutorialStep < tutorialSteps.length - 1)
              GestureDetector(
                onTap: () {
                  // navigateTo('');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  child: Text(
                    "Skip Tutorial",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
  
  List<String> _getTipsForCurrentStep() {
    switch (currentTutorialStep) {
      case 0:
        return [
          "Tap and hold navigation items for quick actions",
          "Swipe left or right to switch between tabs",
          "The active tab is highlighted in your theme color",
        ];
      case 1:
        return [
          "Use voice search by tapping the microphone icon",
          "Recent searches are saved for quick access",
          "Filter results using the advanced search options",
        ];
      case 2:
        return [
          "Customize your dashboard by rearranging widgets",
          "Pull down to refresh your content",
          "Tap on any widget for detailed information",
        ];
      case 3:
        return [
          "Long press action buttons for additional options",
          "Use gestures like swipe for quick actions",
          "Customize quick actions in settings",
        ];
      case 4:
        return [
          "Configure notification preferences in settings",
          "Swipe notifications to dismiss or act on them",
          "Use Do Not Disturb mode when needed",
        ];
      default:
        return [];
    }
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTutorial3View extends StatefulWidget {
  @override
  State<GrlTutorial3View> createState() => _GrlTutorial3ViewState();
}

class _GrlTutorial3ViewState extends State<GrlTutorial3View> {
  int currentStep = 0;
  bool completed = false;

  List<Map<String, dynamic>> tutorialSteps = [
    {
      "title": "Getting Started",
      "description": "Learn the basics of our platform and how to navigate through different features",
      "image": "https://picsum.photos/300/200?random=1&keyword=tutorial",
      "duration": "2 min",
      "completed": true,
    },
    {
      "title": "Profile Setup",
      "description": "Complete your profile to get personalized recommendations and better experience",
      "image": "https://picsum.photos/300/200?random=2&keyword=profile",
      "duration": "3 min",
      "completed": true,
    },
    {
      "title": "Dashboard Overview",
      "description": "Explore your dashboard and understand key metrics and analytics",
      "image": "https://picsum.photos/300/200?random=3&keyword=dashboard",
      "duration": "5 min",
      "completed": false,
    },
    {
      "title": "Advanced Features",
      "description": "Discover advanced tools and features to maximize your productivity",
      "image": "https://picsum.photos/300/200?random=4&keyword=features",
      "duration": "7 min",
      "completed": false,
    },
    {
      "title": "Best Practices",
      "description": "Learn industry best practices and tips for optimal results",
      "image": "https://picsum.photos/300/200?random=5&keyword=practice",
      "duration": "4 min",
      "completed": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interactive Tutorial"),
        actions: [
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: () {
              // Skip tutorial
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
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tutorial Progress",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${((tutorialSteps.where((step) => step["completed"] as bool).length / tutorialSteps.length) * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: tutorialSteps.where((step) => step["completed"] as bool).length / tutorialSteps.length,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(successColor),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${tutorialSteps.where((step) => step["completed"] as bool).length} of ${tutorialSteps.length} steps completed",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Current step display
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: currentStep < tutorialSteps.length 
                              ? (tutorialSteps[currentStep]["completed"] as bool ? successColor : primaryColor)
                              : successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          currentStep < tutorialSteps.length 
                              ? (tutorialSteps[currentStep]["completed"] as bool ? Icons.check : Icons.play_arrow)
                              : Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentStep < tutorialSteps.length 
                                  ? "${tutorialSteps[currentStep]["title"]}"
                                  : "Tutorial Completed!",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              currentStep < tutorialSteps.length 
                                  ? "Step ${currentStep + 1} of ${tutorialSteps.length}"
                                  : "All steps completed successfully",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (currentStep < tutorialSteps.length)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${tutorialSteps[currentStep]["duration"]}",
                            style: TextStyle(
                              color: infoColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  if (currentStep < tutorialSteps.length) ...[
                    SizedBox(height: spMd),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${tutorialSteps[currentStep]["image"]}",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${tutorialSteps[currentStep]["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Tutorial steps list
            Text(
              "All Tutorial Steps",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...List.generate(tutorialSteps.length, (index) {
              final step = tutorialSteps[index];
              final isCompleted = step["completed"] as bool;
              final isCurrent = index == currentStep;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: isCurrent ? Border.all(color: primaryColor, width: 2) : null,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isCompleted 
                            ? successColor 
                            : isCurrent 
                                ? primaryColor 
                                : disabledColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Center(
                        child: isCompleted
                            ? Icon(Icons.check, color: Colors.white, size: 16)
                            : Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
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
                            "${step["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${step["duration"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isCurrent && !isCompleted)
                      QButton(
                        label: "Start",
                        size: bs.sm,
                        onPressed: () {
                          setState(() {
                            tutorialSteps[currentStep]["completed"] = true;
                            if (currentStep < tutorialSteps.length - 1) {
                              currentStep++;
                            } else {
                              completed = true;
                            }
                          });
                        },
                      ),
                    if (isCompleted)
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 20,
                      ),
                  ],
                ),
              );
            }),
            
            if (completed) ...[
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.celebration,
                      color: successColor,
                      size: 48,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Congratulations!",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "You have completed all tutorial steps",
                      style: TextStyle(
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Get Started",
                      size: bs.md,
                      onPressed: () {
                        // Navigate to main app
                      },
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

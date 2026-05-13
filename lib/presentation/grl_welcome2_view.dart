import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWelcome2View extends StatefulWidget {
  @override
  State<GrlWelcome2View> createState() => _GrlWelcome2ViewState();
}

class _GrlWelcome2ViewState extends State<GrlWelcome2View> {
  int currentStep = 0;
  
  final List<Map<String, dynamic>> steps = [
    {
      "icon": Icons.person_add,
      "title": "Create Account",
      "description": "Sign up with your email and create a secure password",
      "color": successColor,
    },
    {
      "icon": Icons.verified,
      "title": "Verify Email",
      "description": "Check your inbox and verify your email address",
      "color": infoColor,
    },
    {
      "icon": Icons.explore,
      "title": "Start Exploring",
      "description": "Discover amazing features and customize your experience",
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: sp2xl),
            
            // Header
            Text(
              "Welcome to Your Journey",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Follow these simple steps to get started",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Step Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(steps.length, (index) {
                return Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: index <= currentStep ? primaryColor : disabledColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (index < steps.length - 1)
                      Container(
                        width: 30,
                        height: 2,
                        color: index < currentStep ? primaryColor : disabledColor,
                        margin: EdgeInsets.symmetric(horizontal: spXs),
                      ),
                  ],
                );
              }),
            ),
            
            SizedBox(height: sp2xl),
            
            // Current Step Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: steps[currentStep]["color"].withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXl),
                    ),
                    child: Icon(
                      steps[currentStep]["icon"],
                      size: 40,
                      color: steps[currentStep]["color"],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "${steps[currentStep]["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "${steps[currentStep]["description"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // All Steps Overview
            Column(
              children: List.generate(steps.length, (index) {
                final step = steps[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: index <= currentStep ? step["color"].withAlpha(20) : Colors.grey.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: index == currentStep ? step["color"] : disabledColor,
                      width: index == currentStep ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: index <= currentStep ? step["color"] : disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          step["icon"],
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
                              "${step["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: index <= currentStep ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${step["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (index < currentStep)
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                    ],
                  ),
                );
              }),
            ),
            
            SizedBox(height: sp2xl),
            
            // Action Buttons
            Row(
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
                    label: currentStep < steps.length - 1 ? "Next" : "Get Started",
                    size: bs.md,
                    onPressed: () {
                      if (currentStep < steps.length - 1) {
                        currentStep++;
                        setState(() {});
                      } else {
                        // navigateTo('');
                      }
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}

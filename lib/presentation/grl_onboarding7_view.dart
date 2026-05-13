import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOnboarding7View extends StatefulWidget {
  const GrlOnboarding7View({super.key});

  @override
  State<GrlOnboarding7View> createState() => _GrlOnboarding7ViewState();
}

class _GrlOnboarding7ViewState extends State<GrlOnboarding7View> {
  int selectedStep = 0;

  final List<Map<String, dynamic>> steps = [
    {
      "icon": Icons.person_add,
      "title": "Create Account",
      "description": "Sign up with your email and create a secure password to get started.",
      "completed": true,
    },
    {
      "icon": Icons.verified_user,
      "title": "Verify Email",
      "description": "Check your inbox and click the verification link we sent you.",
      "completed": false,
    },
    {
      "icon": Icons.settings,
      "title": "Setup Profile",
      "description": "Customize your profile with personal information and preferences.",
      "completed": false,
    },
    {
      "icon": Icons.explore,
      "title": "Explore Features",
      "description": "Discover all the amazing features our platform has to offer.",
      "completed": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Getting Started"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome! Let's get you set up",
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Follow these simple steps to complete your onboarding process and start using our platform.",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: sp2xl),
            Column(
              children: List.generate(steps.length, (index) {
                final step = steps[index];
                final isSelected = index == selectedStep;
                final isCompleted = step["completed"] as bool;
                
                return GestureDetector(
                  onTap: () {
                    selectedStep = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? [shadowMd] : [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isCompleted 
                                ? successColor 
                                : isSelected 
                                    ? primaryColor 
                                    : disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            isCompleted 
                                ? Icons.check 
                                : step["icon"] as IconData,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${step["title"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted 
                                      ? successColor 
                                      : isSelected 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${step["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isCompleted)
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: sp2xl),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue Setup",
                size: bs.md,
                onPressed: () {
                  //navigateTo('profile_setup')
                },
              ),
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Skip for Now",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {
                  //navigateTo('dashboard')
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

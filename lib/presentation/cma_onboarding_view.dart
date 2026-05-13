import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaOnboardingView extends StatefulWidget {
  const CmaOnboardingView({super.key});

  @override
  State<CmaOnboardingView> createState() => _CmaOnboardingViewState();
}

class _CmaOnboardingViewState extends State<CmaOnboardingView> {
  int currentPage = 0;
  
  final List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Manage Your Customers",
      "description": "Keep track of all your customers, their contact information, and interaction history in one centralized place.",
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "Track Sales Pipeline",
      "description": "Monitor your sales opportunities from lead generation to deal closure with powerful pipeline management tools.",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Automate Workflows",
      "description": "Set up automated follow-ups, reminders, and marketing campaigns to nurture your customer relationships efficiently.",
      "icon": Icons.autorenew,
      "color": infoColor,
    },
    {
      "title": "Analytics & Reports",
      "description": "Get insights into your sales performance, customer behavior, and business growth with detailed analytics and reports.",
      "icon": Icons.analytics,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            SizedBox(height: spXl),
            
            // Skip Button
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // ss('Next page'));
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: onboardingData[currentPage]["color"],
                      borderRadius: BorderRadius.circular(radiusXl),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      onboardingData[currentPage]["icon"],
                      size: 70,
                      color: Colors.white,
                    ),
                  ),
                  
                  SizedBox(height: spXl),
                  
                  Text(
                    "${onboardingData[currentPage]["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "${onboardingData[currentPage]["description"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH6,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingData.length, (index) {
                return Container(
                  width: currentPage == index ? 24 : 8,
                  height: 8,
                  margin: EdgeInsets.only(right: spXs),
                  decoration: BoxDecoration(
                    color: currentPage == index ? primaryColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                );
              }),
            ),
            
            SizedBox(height: spXl),
            
            // Navigation Buttons
            Row(
              children: [
                if (currentPage > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      color: disabledColor,
                      size: bs.md,
                      onPressed: () {
                        currentPage--;
                        setState(() {});
                      },
                    ),
                  ),
                
                if (currentPage > 0) SizedBox(width: spMd),
                
                Expanded(
                  child: QButton(
                    label: currentPage == onboardingData.length - 1 ? "Get Started" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentPage == onboardingData.length - 1) {
                        // ss('Next page'));
                      } else {
                        currentPage++;
                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
          ],
        ),
      ),
    );
  }
}

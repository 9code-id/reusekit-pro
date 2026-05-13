import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaOnboardingView extends StatefulWidget {
  const AmaOnboardingView({super.key});

  @override
  State<AmaOnboardingView> createState() => _AmaOnboardingViewState();
}

class _AmaOnboardingViewState extends State<AmaOnboardingView> {
  int currentPage = 0;
  
  List<Map<String, dynamic>> onboardingPages = [
    {
      "title": "Smart Agriculture Management",
      "description": "Transform your farming operations with AI-powered insights and automated management tools",
      "image": "https://picsum.photos/300/400?random=1&keyword=farming",
      "features": [
        "Real-time crop monitoring",
        "Weather-based predictions",
        "Automated irrigation control",
        "Pest detection alerts"
      ]
    },
    {
      "title": "Equipment & Machinery Tracking",
      "description": "Keep track of all your agricultural equipment, schedule maintenance, and optimize usage",
      "image": "https://picsum.photos/300/400?random=2&keyword=tractor",
      "features": [
        "GPS equipment tracking",
        "Maintenance scheduling",
        "Usage analytics",
        "Rental management"
      ]
    },
    {
      "title": "Labor Management System",
      "description": "Efficiently manage your workforce with scheduling, attendance tracking, and payroll automation",
      "image": "https://picsum.photos/300/400?random=3&keyword=workers",
      "features": [
        "Worker scheduling",
        "Attendance tracking",
        "Task assignments",
        "Automated payroll"
      ]
    },
    {
      "title": "Quality Assessment & Post-Harvest",
      "description": "Ensure optimal crop quality with assessment tools and post-harvest management solutions",
      "image": "https://picsum.photos/300/400?random=4&keyword=harvest",
      "features": [
        "Quality assessment",
        "Storage optimization",
        "Market price tracking",
        "Distribution planning"
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header with Skip Button
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + spMd,
              left: spMd,
              right: spMd,
              bottom: spSm,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.agriculture,
                  color: successColor,
                  size: 32,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "AgriManage",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _skipOnboarding();
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
              ],
            ),
          ),

          // Page Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                children: [
                  // Page Indicators
                  Container(
                    margin: EdgeInsets.only(bottom: spLg),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: onboardingPages.asMap().entries.map((entry) {
                        int index = entry.key;
                        return Container(
                          width: currentPage == index ? 24 : 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          decoration: BoxDecoration(
                            color: currentPage == index ? successColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Current Page Content
                  _buildPageContent(onboardingPages[currentPage]),

                  SizedBox(height: spXl),
                ],
              ),
            ),
          ),

          // Bottom Navigation
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                // Navigation Buttons
                Row(
                  children: [
                    if (currentPage > 0)
                      Expanded(
                        child: QButton(
                          label: "Previous",
                          size: bs.md,
                          onPressed: () {
                            _previousPage();
                          },
                        ),
                      ),
                    if (currentPage > 0) SizedBox(width: spMd),
                    Expanded(
                      flex: currentPage == 0 ? 1 : 1,
                      child: QButton(
                        label: currentPage == onboardingPages.length - 1 ? "Get Started" : "Next",
                        size: bs.md,
                        onPressed: () {
                          if (currentPage == onboardingPages.length - 1) {
                            _completeOnboarding();
                          } else {
                            _nextPage();
                          }
                        },
                      ),
                    ),
                  ],
                ),

                // Progress Text
                Text(
                  "${currentPage + 1} of ${onboardingPages.length}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(Map<String, dynamic> pageData) {
    return Column(
      children: [
        // Image
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radiusLg),
            child: Image.network(
              "${pageData["image"]}",
              fit: BoxFit.cover,
            ),
          ),
        ),

        SizedBox(height: spLg),

        // Title
        Text(
          "${pageData["title"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fsH3,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        SizedBox(height: spMd),

        // Description
        Text(
          "${pageData["description"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
            height: 1.5,
          ),
        ),

        SizedBox(height: spLg),

        // Features
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: successColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: successColor.withAlpha(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Key Features:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spSm),
              ...(pageData["features"] as List).map((feature) {
                return Padding(
                  padding: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "$feature",
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
            ],
          ),
        ),
      ],
    );
  }

  void _nextPage() {
    if (currentPage < onboardingPages.length - 1) {
      currentPage++;
      setState(() {});
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      currentPage--;
      setState(() {});
    }
  }

  void _skipOnboarding() {
    // Navigate to login or main app
    ss("Skipping onboarding...");
  }

  void _completeOnboarding() {
    // Complete onboarding and navigate to login
    ss("Onboarding completed! Welcome to AgriManage");
  }
}

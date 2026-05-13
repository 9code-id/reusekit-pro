import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaOnboardingView extends StatefulWidget {
  const ComaOnboardingView({super.key});

  @override
  State<ComaOnboardingView> createState() => _ComaOnboardingViewState();
}

class _ComaOnboardingViewState extends State<ComaOnboardingView> {
  int currentPage = 0;
  PageController pageController = PageController();

  final List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Welcome to COMA",
      "subtitle": "Your AI Medical Assistant",
      "description": "Experience the future of healthcare with our intelligent medical companion designed to assist you 24/7.",
      "icon": Icons.medical_services,
      "color": "#3B82F6",
      "features": [
        "AI-powered medical guidance",
        "24/7 availability",
        "Personalized health insights"
      ]
    },
    {
      "title": "Smart Diagnosis",
      "subtitle": "Advanced Medical Analysis",
      "description": "Get accurate preliminary diagnoses based on your symptoms using our advanced AI algorithms trained on medical data.",
      "icon": Icons.psychology,
      "color": "#10B981",
      "features": [
        "Symptom analysis",
        "Preliminary diagnosis",
        "Treatment recommendations"
      ]
    },
    {
      "title": "Health Monitoring",
      "subtitle": "Track Your Wellness",
      "description": "Monitor your vital signs, medications, and health metrics with our comprehensive tracking system.",
      "icon": Icons.monitor_heart,
      "color": "#F59E0B",
      "features": [
        "Vital signs tracking",
        "Medication reminders",
        "Health progress reports"
      ]
    },
    {
      "title": "Emergency Support",
      "subtitle": "When You Need Help Most",
      "description": "Access emergency protocols, find nearby hospitals, and get immediate assistance during critical situations.",
      "icon": Icons.emergency,
      "color": "#EF4444",
      "features": [
        "Emergency protocols",
        "Hospital locator",
        "Emergency contacts"
      ]
    }
  ];

  void _nextPage() {
    if (currentPage < onboardingData.length - 1) {
      currentPage++;
      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {});
    } else {
      // Navigate to login
      // ss('Next page'));
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      currentPage--;
      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {});
    }
  }

  void _skipOnboarding() {
    // Navigate to login
    // ss('Next page'));
  }

  @override
  Widget build(BuildContext context) {
    final currentData = onboardingData[currentPage];
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(int.parse("0xFF${currentData["color"].substring(1)}")),
              Color(int.parse("0xFF${currentData["color"].substring(1)}")).withAlpha(180),
              primaryColor.withAlpha(120),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with skip button
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "COMA",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    GestureDetector(
                      onTap: _skipOnboarding,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Main content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spLg),
                  child: Column(
                    children: [
                      SizedBox(height: spXl),
                      
                      // Icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(20),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          currentData["icon"],
                          size: 60,
                          color: Color(int.parse("0xFF${currentData["color"].substring(1)}")),
                        ),
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Title and subtitle
                      Text(
                        "${currentData["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentData["subtitle"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withAlpha(200),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      SizedBox(height: spLg),
                      
                      // Description
                      Container(
                        padding: EdgeInsets.all(spLg),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${currentData["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: spLg),
                      
                      // Features
                      Column(
                        children: (currentData["features"] as List<String>).map((feature) {
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      
                      SizedBox(height: spXl),
                    ],
                  ),
                ),
              ),
              
              // Bottom navigation
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    // Page indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onboardingData.length, (index) {
                        return Container(
                          width: index == currentPage ? 24 : 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: index == currentPage 
                                ? Colors.white 
                                : Colors.white.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        );
                      }),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Navigation buttons
                    Row(
                      children: [
                        if (currentPage > 0) ...[
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Previous",
                                size: bs.md,
                                onPressed: _previousPage,
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                        ],
                        Expanded(
                          flex: currentPage == 0 ? 1 : 1,
                          child: Container(
                            width: double.infinity,
                            child: QButton(
                              label: currentPage == onboardingData.length - 1 
                                  ? "Get Started" 
                                  : "Next",
                              size: bs.md,
                              onPressed: _nextPage,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Footer
                    Text(
                      "By continuing, you agree to our Terms of Service and Privacy Policy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(120),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

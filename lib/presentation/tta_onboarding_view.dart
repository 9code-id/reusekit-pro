import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaOnboardingView extends StatefulWidget {
  const TtaOnboardingView({super.key});

  @override
  State<TtaOnboardingView> createState() => _TtaOnboardingViewState();
}

class _TtaOnboardingViewState extends State<TtaOnboardingView> {
  int currentPage = 0;

  List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Welcome to ReuseKit",
      "subtitle": "Your Ultimate Digital Companion",
      "description": "Discover a new way to manage your digital life with our powerful, intuitive tools designed to make your everyday tasks easier and more efficient.",
      "image": "https://picsum.photos/300/300?random=1&keyword=welcome",
      "color": primaryColor,
      "features": [
        "Streamlined workflow management",
        "Intelligent automation tools", 
        "Cross-platform synchronization",
        "Advanced security features"
      ]
    },
    {
      "title": "Powerful Features",
      "subtitle": "Everything You Need in One Place",
      "description": "From advanced analytics to seamless integrations, ReuseKit provides all the tools you need to boost your productivity and achieve your goals.",
      "image": "https://picsum.photos/300/300?random=2&keyword=features",
      "color": infoColor,
      "features": [
        "Real-time collaboration",
        "Smart notifications",
        "Customizable dashboards",
        "Offline functionality"
      ]
    },
    {
      "title": "Secure & Private",
      "subtitle": "Your Data is Safe with Us",
      "description": "We prioritize your privacy and security with end-to-end encryption, secure cloud storage, and comprehensive privacy controls.",
      "image": "https://picsum.photos/300/300?random=3&keyword=security",
      "color": successColor,
      "features": [
        "End-to-end encryption",
        "Biometric authentication",
        "Privacy-first design",
        "GDPR compliant"
      ]
    },
    {
      "title": "Get Started Today",
      "subtitle": "Join Millions of Happy Users",
      "description": "Ready to transform your digital experience? Create your account and start exploring all the amazing features ReuseKit has to offer.",
      "image": "https://picsum.photos/300/300?random=4&keyword=start",
      "color": warningColor,
      "features": [
        "Free 30-day trial",
        "24/7 customer support",
        "Regular feature updates",
        "Cancel anytime"
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              onboardingData[currentPage]["color"] as Color,
              (onboardingData[currentPage]["color"] as Color).withAlpha(200),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with Skip Button
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    // Logo
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.autorenew,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    
                    Spacer(),
                    
                    // Skip Button
                    if (currentPage < onboardingData.length - 1)
                      GestureDetector(
                        onTap: () {
                          _skipToEnd();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: spXl,
                            children: [
                              SizedBox(height: spMd),
                              
                              // Image
                              Container(
                                width: 280,
                                height: 280,
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXl),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(30),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusXl),
                                  child: Image.network(
                                    "${onboardingData[currentPage]["image"]}",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.white.withAlpha(20),
                                        child: Icon(
                                          Icons.image,
                                          color: Colors.white.withAlpha(150),
                                          size: 80,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              // Content
                              Column(
                                spacing: spMd,
                                children: [
                                  Text(
                                    "${onboardingData[currentPage]["title"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      height: 1.2,
                                    ),
                                  ),
                                  
                                  Text(
                                    "${onboardingData[currentPage]["subtitle"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white.withAlpha(230),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spMd),
                                    child: Text(
                                      "${onboardingData[currentPage]["description"]}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withAlpha(200),
                                        height: 1.6,
                                      ),
                                    ),
                                  ),

                                  // Features List
                                  Container(
                                    padding: EdgeInsets.all(spMd),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusMd),
                                    ),
                                    child: Column(
                                      spacing: spSm,
                                      children: (onboardingData[currentPage]["features"] as List<String>).map((feature) {
                                        return Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(width: spSm),
                                            Expanded(
                                              child: Text(
                                                feature,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white.withAlpha(230),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
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

              // Bottom Navigation
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Page Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onboardingData.length, (index) {
                        return Container(
                          width: currentPage == index ? 32 : 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: currentPage == index 
                                ? Colors.white 
                                : Colors.white.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        );
                      }),
                    ),

                    // Navigation Buttons
                    Row(
                      children: [
                        // Previous Button
                        if (currentPage > 0)
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: spMd),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: GestureDetector(
                                onTap: _previousPage,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "Previous",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        
                        if (currentPage > 0) SizedBox(width: spMd),
                        
                        // Next/Get Started Button
                        Expanded(
                          flex: currentPage == 0 ? 1 : 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spMd),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(20),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: _nextPage,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currentPage == onboardingData.length - 1 
                                        ? "Get Started" 
                                        : "Next",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: onboardingData[currentPage]["color"] as Color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    currentPage == onboardingData.length - 1 
                                        ? Icons.rocket_launch
                                        : Icons.arrow_forward,
                                    color: onboardingData[currentPage]["color"] as Color,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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

  void _nextPage() {
    if (currentPage < onboardingData.length - 1) {
      currentPage++;
      setState(() {});
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      currentPage--;
      setState(() {});
    }
  }

  void _skipToEnd() {
    currentPage = onboardingData.length - 1;
    setState(() {});
  }

  void _completeOnboarding() {
    // Navigate to login or main app
    // offAll(LoginView)
    ss("Welcome to ReuseKit! Let's get started.");
  }
}

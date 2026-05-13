import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaOnboardingView extends StatefulWidget {
  const PpaOnboardingView({super.key});

  @override
  State<PpaOnboardingView> createState() => _PpaOnboardingViewState();
}

class _PpaOnboardingViewState extends State<PpaOnboardingView> {
  int currentPage = 0;

  List<Map<String, dynamic>> onboardingPages = [
    {
      "title": "Professional Photography",
      "subtitle": "Capture stunning photos with AI-powered assistance",
      "description": "Transform your photography skills with intelligent composition guides, lighting suggestions, and automatic camera settings optimization.",
      "image": "https://picsum.photos/400/300?random=1&keyword=photography",
      "features": [
        "AI-powered composition guides",
        "Automatic lighting optimization",
        "Real-time camera settings",
        "Professional filters"
      ],
      "color": Color(0xFF4A90E2)
    },
    {
      "title": "Advanced Editing Tools",
      "subtitle": "Edit like a professional photographer",
      "description": "Access powerful editing features including color grading, noise reduction, HDR processing, and batch editing capabilities.",
      "image": "https://picsum.photos/400/300?random=2&keyword=editing",
      "features": [
        "Professional color grading",
        "AI noise reduction",
        "HDR processing",
        "Batch editing tools"
      ],
      "color": Color(0xFF7B68EE)
    },
    {
      "title": "Cloud Storage & Sync",
      "subtitle": "Never lose your precious moments",
      "description": "Automatically backup your photos to secure cloud storage with unlimited space and seamless synchronization across all devices.",
      "image": "https://picsum.photos/400/300?random=3&keyword=cloud",
      "features": [
        "Unlimited cloud storage",
        "Automatic backup",
        "Cross-device sync",
        "Secure encryption"
      ],
      "color": Color(0xFF50C878)
    },
    {
      "title": "AI-Powered Features",
      "subtitle": "Intelligence meets creativity",
      "description": "Leverage artificial intelligence for object recognition, scene detection, automatic tagging, and smart photo organization.",
      "image": "https://picsum.photos/400/300?random=4&keyword=artificial-intelligence",
      "features": [
        "Smart object recognition",
        "Automatic scene detection",
        "Intelligent photo tagging",
        "Smart organization"
      ],
      "color": Color(0xFFFF6B6B)
    },
    {
      "title": "Share & Collaborate",
      "subtitle": "Connect with fellow photographers",
      "description": "Share your work with the photography community, get feedback from professionals, and collaborate on creative projects.",
      "image": "https://picsum.photos/400/300?random=5&keyword=sharing",
      "features": [
        "Community sharing",
        "Professional feedback",
        "Collaborative projects",
        "Portfolio showcase"
      ],
      "color": Color(0xFFFFB347)
    }
  ];

  void nextPage() {
    if (currentPage < onboardingPages.length - 1) {
      currentPage++;
      setState(() {});
    } else {
      completeOnboarding();
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
      setState(() {});
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  void completeOnboarding() {
    //navigateTo('PpaHomeView')
  }

  @override
  Widget build(BuildContext context) {
    final currentPageData = onboardingPages[currentPage];
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              (currentPageData["color"] as Color).withAlpha(20),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with Skip Button
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    // Page Indicator
                    Row(
                      children: List.generate(onboardingPages.length, (index) {
                        return Container(
                          margin: EdgeInsets.only(right: spXs),
                          width: index == currentPage ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: index == currentPage 
                                ? (currentPageData["color"] as Color)
                                : disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                        );
                      }),
                    ),
                    Spacer(),
                    if (currentPage < onboardingPages.length - 1)
                      GestureDetector(
                        onTap: skipOnboarding,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
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
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Column(
                    children: [
                      SizedBox(height: spLg),
                      
                      // Hero Image
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowLg],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Stack(
                            children: [
                              Image.network(
                                "${currentPageData["image"]}",
                                width: double.infinity,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withAlpha(100),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: spLg),

                      // Title and Subtitle
                      Text(
                        "${currentPageData["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH1,
                          fontWeight: FontWeight.bold,
                          color: currentPageData["color"] as Color,
                        ),
                      ),

                      SizedBox(height: spSm),

                      Text(
                        "${currentPageData["subtitle"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH5,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Description
                      Text(
                        "${currentPageData["description"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: spLg),

                      // Features List
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Key Features:",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Column(
                              spacing: spSm,
                              children: (currentPageData["features"] as List<String>).map((feature) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: (currentPageData["color"] as Color).withAlpha(30),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 14,
                                        color: currentPageData["color"] as Color,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        feature,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spXl),
                    ],
                  ),
                ),
              ),

              // Bottom Navigation
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    // Previous Button
                    if (currentPage > 0)
                      Expanded(
                        child: Container(
                          height: 50,
                          child: OutlinedButton(
                            onPressed: previousPage,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: currentPageData["color"] as Color),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: currentPageData["color"] as Color,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Previous",
                                  style: TextStyle(
                                    color: currentPageData["color"] as Color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(child: SizedBox()),

                    if (currentPage > 0)
                      SizedBox(width: spSm),

                    // Next/Get Started Button
                    Expanded(
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: currentPageData["color"] as Color,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currentPage == onboardingPages.length - 1 
                                    ? "Get Started"
                                    : "Next",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Icon(
                                currentPage == onboardingPages.length - 1
                                    ? Icons.rocket_launch
                                    : Icons.arrow_forward,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
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

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmWelcomeView extends StatefulWidget {
  const IwmWelcomeView({Key? key}) : super(key: key);

  @override
  State<IwmWelcomeView> createState() => _IwmWelcomeViewState();
}

class _IwmWelcomeViewState extends State<IwmWelcomeView> {
  int currentPage = 0;
  bool loading = false;

  List<Map<String, dynamic>> onboardingPages = [
    {
      "title": "Smart Inventory Management",
      "subtitle": "Revolutionize Your Warehouse Operations",
      "description": "Take control of your inventory with our intelligent warehouse management system. Real-time tracking, automated alerts, and data-driven insights.",
      "image": "https://picsum.photos/300/200?random=1&keyword=warehouse",
      "features": [
        "Real-time inventory tracking",
        "Automated stock alerts",
        "Barcode & QR scanning",
        "Multi-location support"
      ]
    },
    {
      "title": "Powerful Analytics",
      "subtitle": "Data-Driven Decision Making",
      "description": "Transform your inventory data into actionable insights. Advanced reporting, forecasting, and optimization tools to maximize efficiency.",
      "image": "https://picsum.photos/300/200?random=2&keyword=analytics",
      "features": [
        "Advanced reporting dashboard",
        "Demand forecasting",
        "Cost optimization analysis",
        "Performance metrics"
      ]
    },
    {
      "title": "Seamless Integration",
      "subtitle": "Connect Everything Together",
      "description": "Integrate seamlessly with your existing systems. ERP integration, API connectivity, and cloud synchronization for unified operations.",
      "image": "https://picsum.photos/300/200?random=3&keyword=integration",
      "features": [
        "ERP system integration",
        "Cloud synchronization",
        "API connectivity",
        "Third-party app support"
      ]
    }
  ];

  void _nextPage() {
    if (currentPage < onboardingPages.length - 1) {
      setState(() {
        currentPage++;
      });
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  void _skipToEnd() {
    setState(() {
      currentPage = onboardingPages.length - 1;
    });
  }

  void _getStarted() {
    // Navigate to login or registration
    ss("Welcome to Intelligent Warehouse Management!");
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: onboardingPages.asMap().entries.map((entry) {
        return Container(
          width: currentPage == entry.key ? 20 : 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusLg),
            color: currentPage == entry.key ? primaryColor : disabledColor,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
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
      ),
    );
  }

  Widget _buildOnboardingPage(Map<String, dynamic> page) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: spXl),
          
          // Logo or Brand
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Icon(
              Icons.inventory,
              color: Colors.white,
              size: 40,
            ),
          ),
          SizedBox(height: spMd),
          
          Text(
            "IWM Pro",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXl),

          // Main Image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusMd),
              child: Image.network(
                "${page["image"]}",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),
          SizedBox(height: spLg),

          // Title
          Text(
            "${page["title"]}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spXs),

          // Subtitle
          Text(
            "${page["subtitle"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: secondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spMd),

          // Description
          Text(
            "${page["description"]}",
            style: TextStyle(
              fontSize: 15,
              color: disabledBoldColor,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spLg),

          // Features List
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: primaryColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Key Features:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...(page["features"] as List<String>).map((feature) => _buildFeatureItem(feature)),
              ],
            ),
          ),
          SizedBox(height: spXl),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            if (currentPage < onboardingPages.length - 1)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: _skipToEnd,
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
              child: _buildOnboardingPage(onboardingPages[currentPage]),
            ),

            // Bottom Navigation
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  // Page Indicator
                  _buildPageIndicator(),
                  SizedBox(height: spMd),

                  // Navigation Buttons
                  Row(
                    children: [
                      // Previous Button
                      if (currentPage > 0)
                        Expanded(
                          child: QButton(
                            label: "Previous",
                            icon: Icons.arrow_back,
                            size: bs.md,
                            onPressed: _previousPage,
                          ),
                        ),
                      
                      if (currentPage > 0) SizedBox(width: spSm),

                      // Next/Get Started Button
                      Expanded(
                        flex: currentPage == 0 ? 1 : 1,
                        child: QButton(
                          label: currentPage == onboardingPages.length - 1 
                            ? "Get Started" 
                            : "Next",
                          icon: currentPage == onboardingPages.length - 1 
                            ? Icons.rocket_launch 
                            : Icons.arrow_forward,
                          size: bs.md,
                          onPressed: currentPage == onboardingPages.length - 1 
                            ? _getStarted 
                            : _nextPage,
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
    );
  }
}

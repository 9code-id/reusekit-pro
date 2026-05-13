import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaOnboardingView extends StatefulWidget {
  const FwaOnboardingView({super.key});

  @override
  State<FwaOnboardingView> createState() => _FwaOnboardingViewState();
}

class _FwaOnboardingViewState extends State<FwaOnboardingView> {
  int currentPage = 0;
  
  final List<Map<String, dynamic>> onboardingPages = [
    {
      "title": "Track Your Nutrition",
      "description": "Monitor your daily calorie intake and macronutrients with our advanced food tracking system. Get detailed nutritional insights for better health.",
      "image": "https://picsum.photos/300/200?random=1&keyword=nutrition",
      "color": successColor,
    },
    {
      "title": "Find Healthy Recipes",
      "description": "Discover thousands of healthy recipes curated by nutritionists. Filter by dietary preferences, allergies, and nutritional goals.",
      "image": "https://picsum.photos/300/200?random=2&keyword=recipes",
      "color": primaryColor,
    },
    {
      "title": "Connect with Trainers",
      "description": "Get personalized workout plans and nutrition advice from certified fitness trainers and nutritionists near you.",
      "image": "https://picsum.photos/300/200?random=3&keyword=fitness",
      "color": warningColor,
    },
    {
      "title": "Achieve Your Goals",
      "description": "Set personalized fitness and nutrition goals. Track your progress with detailed analytics and celebrate your achievements.",
      "image": "https://picsum.photos/300/200?random=4&keyword=goals",
      "color": infoColor,
    },
  ];

  void _nextPage() {
    if (currentPage < onboardingPages.length - 1) {
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

  void _completeOnboarding() {
    // Navigate to main app
    // await offAll(const MainView());
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingPages.length, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index ? primaryColor : disabledColor,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
        );
      }),
    );
  }

  Widget _buildOnboardingPage(Map<String, dynamic> page) {
    return Container(
      padding: EdgeInsets.all(spLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image Section
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusXl),
              boxShadow: [shadowLg],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusXl),
              child: Image.network(
                "${page["image"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: spXl),
          
          // Content Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Column(
              children: [
                // Title
                Text(
                  "${page["title"]}",
                  style: TextStyle(
                    fontSize: fsH2,
                    fontWeight: FontWeight.bold,
                    color: page["color"],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: spMd),
                
                // Description
                Text(
                  "${page["description"]}",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: spXl),
          
          // Page Indicator
          _buildPageIndicator(),
          SizedBox(height: spXl),
          
          // Navigation Buttons
          Row(
            children: [
              // Previous Button
              if (currentPage > 0)
                Expanded(
                  child: QButton(
                    label: "Previous",
                    size: bs.md,
                    color: disabledBoldColor,
                    onPressed: _previousPage,
                  ),
                ),
              
              if (currentPage > 0) SizedBox(width: spMd),
              
              // Next/Get Started Button
              Expanded(
                flex: currentPage == 0 ? 1 : 1,
                child: QButton(
                  label: currentPage == onboardingPages.length - 1 
                      ? "Get Started" 
                      : "Next",
                  size: bs.md,
                  onPressed: _nextPage,
                ),
              ),
            ],
          ),
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
            // Skip Button
            Container(
              padding: EdgeInsets.all(spMd),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _completeOnboarding,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
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
            ),
            
            // Main Content
            Expanded(
              child: _buildOnboardingPage(onboardingPages[currentPage]),
            ),
            
            // Bottom Section with App Logo
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.restaurant_menu,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "FitWise App",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Your fitness and nutrition companion",
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaOnboardingView extends StatefulWidget {
  const AbaOnboardingView({super.key});

  @override
  State<AbaOnboardingView> createState() => _AbaOnboardingViewState();
}

class _AbaOnboardingViewState extends State<AbaOnboardingView> {
  int currentStep = 0;
  
  final List<Map<String, dynamic>> onboardingSteps = [
    {
      "title": "Welcome to ABA Banking",
      "subtitle": "Your trusted digital banking partner",
      "description": "Experience secure, fast, and convenient banking services right at your fingertips. Manage your finances with confidence.",
      "image": "https://picsum.photos/300/250?random=1&keyword=banking",
      "icon": Icons.account_balance,
      "color": Color(0xFF2E86AB),
    },
    {
      "title": "Secure Transactions",
      "subtitle": "Bank with complete peace of mind",
      "description": "Advanced encryption and biometric security ensure your money and data are always protected. Your security is our priority.",
      "image": "https://picsum.photos/300/250?random=2&keyword=security",
      "icon": Icons.security,
      "color": Color(0xFF28A745),
    },
    {
      "title": "Smart Financial Tools",
      "subtitle": "Manage your money intelligently",
      "description": "Track expenses, set budgets, and get insights into your spending patterns. Make informed financial decisions.",
      "image": "https://picsum.photos/300/250?random=3&keyword=analytics",
      "icon": Icons.analytics,
      "color": Color(0xFF6F42C1),
    },
    {
      "title": "24/7 Support",
      "subtitle": "We're here whenever you need us",
      "description": "Get instant help through chat, call, or visit any of our branches. Our support team is always ready to assist you.",
      "image": "https://picsum.photos/300/250?random=4&keyword=support",
      "icon": Icons.support_agent,
      "color": Color(0xFFE67E22),
    },
    {
      "title": "Get Started",
      "subtitle": "Ready to begin your journey?",
      "description": "Create your account now and start enjoying seamless banking experience. Join millions of satisfied customers.",
      "image": "https://picsum.photos/300/250?random=5&keyword=success",
      "icon": Icons.rocket_launch,
      "color": Color(0xFFDC3545),
    },
  ];

  final List<Map<String, dynamic>> features = [
    {
      "title": "Instant Transfers",
      "description": "Send money instantly to any bank account",
      "icon": Icons.flash_on,
    },
    {
      "title": "Bill Payments",
      "description": "Pay all your bills in one place",
      "icon": Icons.receipt_long,
    },
    {
      "title": "Investment Options",
      "description": "Grow your wealth with smart investments",
      "icon": Icons.trending_up,
    },
    {
      "title": "Digital Cards",
      "description": "Virtual and physical cards for all needs",
      "icon": Icons.credit_card,
    },
  ];

  void nextStep() {
    if (currentStep < onboardingSteps.length - 1) {
      currentStep++;
      setState(() {});
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void skipOnboarding() {
    // Navigate to login/register
    // navigateTo(LoginView());
  }

  void completeOnboarding() {
    // Navigate to registration
    // navigateTo(RegisterView());
  }

  @override
  Widget build(BuildContext context) {
    final step = onboardingSteps[currentStep];
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              (step["color"] as Color).withAlpha(30),
              Colors.white,
              (step["color"] as Color).withAlpha(20),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "ABA",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    // Skip Button
                    if (currentStep < onboardingSteps.length - 1)
                      GestureDetector(
                        onTap: skipOnboarding,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              // Progress Indicators
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Row(
                  children: List.generate(onboardingSteps.length, (index) {
                    return Expanded(
                      child: Container(
                        height: 4,
                        margin: EdgeInsets.only(right: index < onboardingSteps.length - 1 ? spXs : 0),
                        decoration: BoxDecoration(
                          color: index <= currentStep ? (step["color"] as Color) : disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Content Area
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Column(
                    children: [
                      // Main Icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: (step["color"] as Color).withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          step["icon"] as IconData,
                          size: 40,
                          color: step["color"] as Color,
                        ),
                      ),
                      
                      SizedBox(height: spLg),
                      
                      // Main Image
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${step["image"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: spLg),
                      
                      // Title
                      Text(
                        "${step["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Subtitle
                      Text(
                        "${step["subtitle"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.w600,
                          color: step["color"] as Color,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Description
                      Text(
                        "${step["description"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),
                      
                      SizedBox(height: spLg),
                      
                      // Features Section (only on specific steps)
                      if (currentStep == 2)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Key Features",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              ...features.map((feature) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: spSm),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Icon(
                                          feature["icon"] as IconData,
                                          size: 20,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${feature["title"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "${feature["description"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
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
                child: Column(
                  children: [
                    // Step Counter
                    Text(
                      "${currentStep + 1} of ${onboardingSteps.length}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Navigation Buttons
                    Row(
                      children: [
                        // Back Button
                        if (currentStep > 0)
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: spSm),
                              child: QButton(
                                label: "Back",
                                color: disabledColor,
                                size: bs.md,
                                onPressed: previousStep,
                              ),
                            ),
                          ),
                        
                        // Next/Get Started Button
                        Expanded(
                          flex: currentStep == 0 ? 1 : 2,
                          child: QButton(
                            label: currentStep == onboardingSteps.length - 1 
                                ? "Get Started" 
                                : "Next",
                            color: step["color"] as Color,
                            size: bs.md,
                            onPressed: currentStep == onboardingSteps.length - 1 
                                ? completeOnboarding 
                                : nextStep,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Login Option
                    if (currentStep == onboardingSteps.length - 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to login
                              // navigateTo(LoginView());
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
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
}

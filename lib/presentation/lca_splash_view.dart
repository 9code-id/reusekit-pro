import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaSplashView extends StatefulWidget {
  const LcaSplashView({super.key});

  @override
  State<LcaSplashView> createState() => _LcaSplashViewState();
}

class _LcaSplashViewState extends State<LcaSplashView> {
  double loadingProgress = 0.0;
  String loadingText = "Initializing...";
  
  @override
  void initState() {
    super.initState();
    _startLoadingProcess();
  }

  void _startLoadingProcess() {
    List<String> loadingSteps = [
      "Initializing...",
      "Loading configurations...",
      "Connecting to server...",
      "Preparing interface...",
      "Almost ready...",
    ];

    int currentStep = 0;
    
    Timer.periodic(Duration(milliseconds: 800), (timer) {
      if (currentStep < loadingSteps.length) {
        setState(() {
          loadingProgress = (currentStep + 1) / loadingSteps.length;
          loadingText = loadingSteps[currentStep];
        });
        currentStep++;
      } else {
        timer.cancel();
        // Navigate to onboarding or main screen
        Future.delayed(Duration(milliseconds: 500), () {
          //navigateTo(LcaOnboardingView());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              primaryColor.withAlpha(180),
              primaryColor.withAlpha(120),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top spacing
              Spacer(flex: 2),
              
              // Logo and App Name
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    // App Logo
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radius3xl),
                        boxShadow: [shadowLg],
                      ),
                      child: Icon(
                        Icons.savings,
                        size: 60,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // App Name
                    Text(
                      "LCA",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 4,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // App Tagline
                    Text(
                      "Life Credit Assistant",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withAlpha(230),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                    
                    SizedBox(height: spXs),
                    
                    // App Description
                    Text(
                      "Smart Financial Management",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(180),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              
              Spacer(flex: 2),
              
              // Loading Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: spLg),
                child: Column(
                  children: [
                    // Loading Progress Bar
                    Container(
                      width: double.infinity,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: LinearProgressIndicator(
                          value: loadingProgress,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Loading Text
                    Text(
                      loadingText,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    SizedBox(height: spXs),
                    
                    // Loading Percentage
                    Text(
                      "${(loadingProgress * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(150),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              
              Spacer(flex: 1),
              
              // Bottom Section
              Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    // Features Preview
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFeatureIcon(Icons.account_balance, "Banking"),
                        _buildFeatureIcon(Icons.credit_card, "Cards"),
                        _buildFeatureIcon(Icons.analytics, "Analytics"),
                        _buildFeatureIcon(Icons.security, "Secure"),
                      ],
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Version and Copyright
                    Column(
                      children: [
                        Text(
                          "Version 2.1.0",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(150),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "© 2024 LCA Financial Solutions",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withAlpha(120),
                            fontWeight: FontWeight.w300,
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

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withAlpha(180),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

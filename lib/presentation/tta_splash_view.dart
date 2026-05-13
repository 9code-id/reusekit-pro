import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaSplashView extends StatefulWidget {
  const TtaSplashView({super.key});

  @override
  State<TtaSplashView> createState() => _TtaSplashViewState();
}

class _TtaSplashViewState extends State<TtaSplashView> with TickerProviderStateMixin {
  bool showProgress = false;
  double progress = 0.0;
  String loadingText = "Initializing...";

  List<String> loadingSteps = [
    "Initializing app...",
    "Loading resources...",
    "Checking updates...",
    "Verifying security...",
    "Preparing interface...",
    "Almost ready...",
  ];

  @override
  void initState() {
    super.initState();
    _startSplashSequence();
  }

  void _startSplashSequence() async {
    // Wait for initial splash animation
    await Future.delayed(Duration(seconds: 2));
    
    showProgress = true;
    setState(() {});

    // Simulate loading process
    for (int i = 0; i < loadingSteps.length; i++) {
      loadingText = loadingSteps[i];
      setState(() {});
      
      // Simulate progress
      for (int j = 0; j <= 100; j += 20) {
        progress = (i * 100 + j) / (loadingSteps.length * 100);
        setState(() {});
        await Future.delayed(Duration(milliseconds: 100));
      }
      
      await Future.delayed(Duration(milliseconds: 500));
    }

    // Complete loading
    progress = 1.0;
    loadingText = "Ready!";
    setState(() {});
    
    await Future.delayed(Duration(seconds: 1));
    
    // Navigate to next screen
    // offAll(OnboardingView)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              primaryColor.withAlpha(230),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: spLg,
                    children: [
                      // App Logo/Icon
                      Container(
                        width: 120,
                        height: 120,
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
                        child: Icon(
                          Icons.autorenew,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),

                      // App Name
                      Column(
                        spacing: spSm,
                        children: [
                          Text(
                            "ReuseKit",
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            "Your Digital Companion",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withAlpha(230),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),

                      // Version Info
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "Version 2.1.3",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Loading Section
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: spXl),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: spMd,
                    children: [
                      if (showProgress) ...[
                        // Progress Bar
                        Container(
                          width: double.infinity,
                          child: Column(
                            spacing: spSm,
                            children: [
                              // Loading Text
                              Text(
                                loadingText,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withAlpha(230),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              
                              // Progress Bar
                              Container(
                                width: double.infinity,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: MediaQuery.of(context).size.width * 0.8 * progress,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white.withAlpha(100),
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Progress Percentage
                              Text(
                                "${(progress * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(180),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        // Initial Loading Indicator
                        Container(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3,
                          ),
                        ),
                        Text(
                          "Loading...",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(230),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],

                      SizedBox(height: spXl),

                      // Company Info
                      Column(
                        spacing: spXs,
                        children: [
                          Text(
                            "Powered by ReuseKit Technologies",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(150),
                            ),
                          ),
                          Text(
                            "© 2024 All rights reserved",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(150),
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
    );
  }
}

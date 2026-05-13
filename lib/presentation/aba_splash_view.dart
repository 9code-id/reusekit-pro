import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaSplashView extends StatefulWidget {
  const AbaSplashView({super.key});

  @override
  State<AbaSplashView> createState() => _AbaSplashViewState();
}

class _AbaSplashViewState extends State<AbaSplashView> with TickerProviderStateMixin {
  bool loading = true;
  double logoOpacity = 0.0;
  double textOpacity = 0.0;
  double progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _startSplashSequence();
  }

  void _startSplashSequence() async {
    // Show logo with fade in
    await Future.delayed(Duration(milliseconds: 500));
    logoOpacity = 1.0;
    setState(() {});

    // Show text after logo
    await Future.delayed(Duration(milliseconds: 800));
    textOpacity = 1.0;
    setState(() {});

    // Start progress animation
    await Future.delayed(Duration(milliseconds: 1000));
    _animateProgress();

    // Navigate after loading complete
    await Future.delayed(Duration(milliseconds: 4000));
    loading = false;
    setState(() {});
  }

  void _animateProgress() async {
    for (int i = 0; i <= 100; i += 2) {
      await Future.delayed(Duration(milliseconds: 30));
      progressValue = i / 100;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              primaryColor.withAlpha(200),
              primaryColor.withAlpha(150),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),

            // Logo Section
            AnimatedOpacity(
              opacity: logoOpacity,
              duration: Duration(milliseconds: 1000),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.analytics,
                  size: 60,
                  color: primaryColor,
                ),
              ),
            ),

            SizedBox(height: spLg),

            // App Name and Tagline
            AnimatedOpacity(
              opacity: textOpacity,
              duration: Duration(milliseconds: 1000),
              child: Column(
                children: [
                  Text(
                    "ABA Analytics",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Applied Behavior Analysis Platform",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Data-Driven Behavioral Insights",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(170),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(flex: 2),

            // Loading Section
            if (loading) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: spLg),
                child: Column(
                  children: [
                    // Progress Bar
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: progressValue,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    // Loading Text
                    Text(
                      "Initializing Analytics Engine...",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(180),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(progressValue * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(150),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Get Started Button (shown after loading)
              Container(
                padding: EdgeInsets.symmetric(horizontal: spLg),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to onboarding
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: primaryColor,
                          padding: EdgeInsets.symmetric(vertical: spMd),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    TextButton(
                      onPressed: () {
                        // Skip to login
                      },
                      child: Text(
                        "Skip Introduction",
                        style: TextStyle(
                          color: Colors.white.withAlpha(180),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: spXl),

            // Footer
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.security,
                      size: 16,
                      color: Colors.white.withAlpha(120),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "HIPAA Compliant",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(120),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.verified,
                      size: 16,
                      color: Colors.white.withAlpha(120),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Evidence-Based",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(120),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Version 2.1.0",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withAlpha(100),
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "© 2024 ABA Analytics. All rights reserved.",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withAlpha(80),
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

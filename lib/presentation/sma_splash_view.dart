import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaSplashView extends StatefulWidget {
  const SmaSplashView({super.key});

  @override
  State<SmaSplashView> createState() => _SmaSplashViewState();
}

class _SmaSplashViewState extends State<SmaSplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() async {
    await Future.delayed(Duration(seconds: 3));
    // Navigate to onboarding or main app
    // ss('Next page'));
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
              primaryColor.withValues(alpha: 0.8),
              secondaryColor,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowLg],
                ),
                child: Icon(
                  Icons.share,
                  size: 60,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spLg),

              // App Name
              Text(
                "SocieLink",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: spSm),

              // Tagline
              Text(
                "Connect • Share • Discover",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: spXl),

              // Loading Indicator
              Container(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(height: spMd),

              // Loading Text
              Text(
                "Loading your social world...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),

              SizedBox(height: spXl * 2),

              // Version Info
              Text(
                "Version 1.0.0",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

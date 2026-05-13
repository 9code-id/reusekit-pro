import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSplash1View extends StatefulWidget {
  @override
  State<GrlSplash1View> createState() => _GrlSplash1ViewState();
}

class _GrlSplash1ViewState extends State<GrlSplash1View> {
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
              primaryColor.withAlpha(180),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Spacer(flex: 2),
              
              // Logo Section
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusXl),
                  boxShadow: [shadowLg],
                ),
                child: Icon(
                  Icons.rocket_launch,
                  size: 60,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spLg),
              
              // App Name
              Text(
                "LaunchPad",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              SizedBox(height: spSm),
              
              // Tagline
              Text(
                "Your journey begins here",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(200),
                ),
              ),
              
              Spacer(flex: 3),
              
              // Loading Indicator
              Container(
                width: 80,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(80),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Loading Text
              Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(180),
                ),
              ),
              
              SizedBox(height: spXl),
            ],
          ),
        ),
      ),
    );
  }
}

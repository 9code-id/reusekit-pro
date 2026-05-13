import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSplash4View extends StatefulWidget {
  @override
  State<GrlSplash4View> createState() => _GrlSplash4ViewState();
}

class _GrlSplash4ViewState extends State<GrlSplash4View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Spacer(flex: 2),
              
              // Minimalist Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Center(
                  child: Text(
                    "M",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: spXl),
              
              // App Name
              Text(
                "Minimal",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              // Tagline
              Text(
                "Less is more",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              
              Spacer(flex: 3),
              
              // Clean Progress Bar
              Container(
                width: 120,
                height: 2,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Version Info
              Text(
                "Version 1.0.0",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
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

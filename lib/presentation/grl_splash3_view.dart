import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSplash3View extends StatefulWidget {
  @override
  State<GrlSplash3View> createState() => _GrlSplash3ViewState();
}

class _GrlSplash3ViewState extends State<GrlSplash3View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Spacer(flex: 2),
              
              // Geometric Logo
              Container(
                width: 140,
                height: 140,
                child: Stack(
                  children: [
                    // Outer ring
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withAlpha(80),
                          width: 2,
                        ),
                      ),
                    ),
                    
                    // Inner circle
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowLg],
                        ),
                        child: Icon(
                          Icons.diamond,
                          size: 50,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // App Name
              Text(
                "Crystalline",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
              
              SizedBox(height: spSm),
              
              // Subtitle
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXl),
                child: Text(
                  "Crystal clear solutions for modern living",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(200),
                    height: 1.4,
                  ),
                ),
              ),
              
              Spacer(flex: 3),
              
              // Progress Ring
              Container(
                width: 60,
                height: 60,
                child: Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withAlpha(80),
                          width: 3,
                        ),
                      ),
                    ),
                    
                    Container(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "Initializing...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(180),
                  letterSpacing: 1.0,
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

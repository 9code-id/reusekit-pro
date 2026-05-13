import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSplash7View extends StatefulWidget {
  @override
  State<GrlSplash7View> createState() => _GrlSplash7ViewState();
}

class _GrlSplash7ViewState extends State<GrlSplash7View> {
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
              Color(0xFF2E8B57),
              Color(0xFF228B22),
              Color(0xFF006400),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Spacer(flex: 2),
              
              // Nature Logo
              Container(
                width: 150,
                height: 150,
                child: Stack(
                  children: [
                    // Background circle
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(40),
                        shape: BoxShape.circle,
                      ),
                    ),
                    
                    // Tree icon
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
                          Icons.park,
                          size: 50,
                          color: Color(0xFF228B22),
                        ),
                      ),
                    ),
                    
                    // Leaf decorations
                    Positioned(
                      top: 20,
                      right: 30,
                      child: Icon(
                        Icons.eco,
                        size: 20,
                        color: Colors.white.withAlpha(180),
                      ),
                    ),
                    
                    Positioned(
                      bottom: 30,
                      left: 25,
                      child: Icon(
                        Icons.local_florist,
                        size: 18,
                        color: Colors.white.withAlpha(150),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // App Name
              Text(
                "EcoLife",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              SizedBox(height: spSm),
              
              // Subtitle
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXl),
                child: Text(
                  "Live sustainably, love naturally",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(200),
                    height: 1.4,
                  ),
                ),
              ),
              
              Spacer(flex: 3),
              
              // Growing Progress
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: spXxs),
                        width: 6,
                        height: 20 + (index * 8).toDouble(),
                        decoration: BoxDecoration(
                          color: index < 3 ? Colors.white : Colors.white.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      );
                    }),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "Growing...",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spXl),
            ],
          ),
        ),
      ),
    );
  }
}

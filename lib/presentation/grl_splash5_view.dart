import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSplash5View extends StatefulWidget {
  @override
  State<GrlSplash5View> createState() => _GrlSplash5ViewState();
}

class _GrlSplash5ViewState extends State<GrlSplash5View> {
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
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Spacer(flex: 2),
              
              // Cosmic Logo
              Container(
                width: 160,
                height: 160,
                child: Stack(
                  children: [
                    // Outer glow
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFF4fc3f7).withAlpha(80),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    
                    // Planet
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF4fc3f7),
                              Color(0xFF29b6f6),
                              Color(0xFF0288d1),
                            ],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF4fc3f7).withAlpha(100),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.language,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    
                    // Orbit ring
                    Center(
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withAlpha(60),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // App Name
              Text(
                "COSMOS",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 3.0,
                ),
              ),
              
              SizedBox(height: spSm),
              
              // Subtitle
              Text(
                "Explore the infinite possibilities",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4fc3f7),
                  letterSpacing: 1.0,
                ),
              ),
              
              Spacer(flex: 3),
              
              // Starfield Effect
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: spXs),
                    width: index == 2 ? 8 : 4,
                    height: index == 2 ? 8 : 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withAlpha(index == 2 ? 255 : 120),
                    ),
                  );
                }),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "Launching...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(180),
                  letterSpacing: 1.5,
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

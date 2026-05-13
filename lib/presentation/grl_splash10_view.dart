import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSplash10View extends StatefulWidget {
  @override
  State<GrlSplash10View> createState() => _GrlSplash10ViewState();
}

class _GrlSplash10ViewState extends State<GrlSplash10View> {
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
              Color(0xFFff9a9e),
              Color(0xFFfecfef),
              Color(0xFFfecfef),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Spacer(flex: 2),
              
              // Elegant Logo
              Container(
                width: 150,
                height: 150,
                child: Stack(
                  children: [
                    // Soft shadow
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(60),
                        shape: BoxShape.circle,
                      ),
                    ),
                    
                    // Main logo container
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowLg],
                        ),
                        child: Icon(
                          Icons.auto_awesome,
                          size: 50,
                          color: Color(0xFFff9a9e),
                        ),
                      ),
                    ),
                    
                    // Sparkle decorations
                    Positioned(
                      top: 30,
                      right: 40,
                      child: Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    
                    Positioned(
                      bottom: 40,
                      left: 35,
                      child: Icon(
                        Icons.star_border,
                        size: 14,
                        color: Colors.white.withAlpha(180),
                      ),
                    ),
                    
                    Positioned(
                      top: 60,
                      left: 20,
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.white.withAlpha(150),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // App Name
              Text(
                "Dreamscape",
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
                  "Where imagination meets reality",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(200),
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              
              Spacer(flex: 3),
              
              // Floating Elements
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(3, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: spSm),
                      child: Column(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(180),
                              shape: BoxShape.circle,
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(120),
                              shape: BoxShape.circle,
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Container(
                            width: 2,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(80),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "Manifesting dreams...",
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

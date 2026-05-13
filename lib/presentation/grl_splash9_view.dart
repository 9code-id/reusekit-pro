import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSplash9View extends StatefulWidget {
  @override
  State<GrlSplash9View> createState() => _GrlSplash9ViewState();
}

class _GrlSplash9ViewState extends State<GrlSplash9View> {
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
              Color(0xFF1e3c72),
              Color(0xFF2a5298),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Spacer(flex: 2),
              
              // Gaming Logo
              Container(
                width: 140,
                height: 140,
                child: Stack(
                  children: [
                    // Hexagon background
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowLg],
                      ),
                    ),
                    
                    // Gaming controller icon
                    Center(
                      child: Icon(
                        Icons.sports_esports,
                        size: 60,
                        color: primaryColor,
                      ),
                    ),
                    
                    // Corner decorations
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // App Name
              Text(
                "GameHub",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              SizedBox(height: spSm),
              
              // Subtitle
              Text(
                "Level up your gaming experience",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(200),
                ),
              ),
              
              Spacer(flex: 3),
              
              // Loading Progress with Game Elements
              Column(
                children: [
                  // Progress bar
                  Container(
                    width: 200,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(60),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.65,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [successColor, infoColor],
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // XP Style
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Loading... 65%",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(180),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.yellow,
                      ),
                    ],
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

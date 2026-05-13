import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSplash6View extends StatefulWidget {
  @override
  State<GrlSplash6View> createState() => _GrlSplash6ViewState();
}

class _GrlSplash6ViewState extends State<GrlSplash6View> {
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
              Color(0xFFf093fb),
              Color(0xFFf5576c),
              Color(0xFFf093fb),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Spacer(flex: 2),
              
              // Heart Logo with Pulse Effect
              Container(
                width: 140,
                height: 140,
                child: Stack(
                  children: [
                    // Pulse rings
                    ...List.generate(3, (index) {
                      return Center(
                        child: Container(
                          width: 140 - (index * 20).toDouble(),
                          height: 140 - (index * 20).toDouble(),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withAlpha(80 - (index * 20)),
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    }),
                    
                    // Heart Icon
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowLg],
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 40,
                          color: Color(0xFFf5576c),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // App Name
              Text(
                "LoveLink",
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
                  "Connect hearts, share moments",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(200),
                    height: 1.4,
                  ),
                ),
              ),
              
              Spacer(flex: 3),
              
              // Hearts Animation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: spXs),
                    child: Icon(
                      Icons.favorite,
                      size: 16 + (index * 2).toDouble(),
                      color: Colors.white.withAlpha(150 + (index * 25)),
                    ),
                  );
                }),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "Spreading love...",
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

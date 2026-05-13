import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSplash8View extends StatefulWidget {
  @override
  State<GrlSplash8View> createState() => _GrlSplash8ViewState();
}

class _GrlSplash8ViewState extends State<GrlSplash8View> {
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
              
              // Music Logo
              Container(
                width: 160,
                height: 160,
                child: Stack(
                  children: [
                    // Vinyl record background
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        shape: BoxShape.circle,
                        boxShadow: [shadowLg],
                      ),
                    ),
                    
                    // Record grooves
                    ...List.generate(4, (index) {
                      return Center(
                        child: Container(
                          width: 160 - (index * 30).toDouble(),
                          height: 160 - (index * 30).toDouble(),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withAlpha(30),
                              width: 1,
                            ),
                          ),
                        ),
                      );
                    }),
                    
                    // Center label
                    Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.music_note,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // App Name
              Text(
                "SoundWave",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              SizedBox(height: spSm),
              
              // Subtitle
              Text(
                "Your rhythm, your world",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(200),
                ),
              ),
              
              Spacer(flex: 3),
              
              // Sound Visualizer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (index) {
                  List<double> heights = [20, 35, 45, 60, 40, 30, 25];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: spXxs),
                    width: 4,
                    height: heights[index],
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  );
                }),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "Tuning in...",
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

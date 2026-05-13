import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaSplashView extends StatefulWidget {
  const GeaSplashView({super.key});

  @override
  State<GeaSplashView> createState() => _GeaSplashViewState();
}

class _GeaSplashViewState extends State<GeaSplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late Animation<double> _logoAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _logoController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut)
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut)
    );
    
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    _logoController.forward();
    
    await Future.delayed(Duration(milliseconds: 800));
    _fadeController.forward();
    
    await Future.delayed(Duration(milliseconds: 2000));
    _navigateToNext();
  }

  void _navigateToNext() {
    //navigateTo('GeaOnboardingView')
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor,
              primaryColor.withAlpha(230),
              Colors.purple.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated Logo
                      ScaleTransition(
                        scale: _logoAnimation,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusXl),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(50),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.games,
                            size: 60,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: spLg),
                      
                      // App Name
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          "GameZone",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Tagline
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          "Play • Discover • Connect",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(200),
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Features Preview
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildFeatureIcon(Icons.sports_esports, "10K+ Games"),
                            _buildFeatureIcon(Icons.group, "Active Community"),
                            _buildFeatureIcon(Icons.star, "Premium Quality"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Loading Animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  margin: EdgeInsets.only(bottom: spXl),
                  child: Column(
                    children: [
                      Text(
                        "Loading your gaming experience...",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(180),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: 200,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Skip Button
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: GestureDetector(
                    onTap: _navigateToNext,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: Colors.white.withAlpha(80),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(180),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

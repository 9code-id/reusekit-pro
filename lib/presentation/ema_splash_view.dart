import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSplashView extends StatefulWidget {
  const EmaSplashView({super.key});

  @override
  State<EmaSplashView> createState() => _EmaSplashViewState();
}

class _EmaSplashViewState extends State<EmaSplashView> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    
    _startAnimation();
  }
  
  void _startAnimation() {
    _animationController.forward();
    
    // Navigate to onboarding after animation
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        ss("Navigating to onboarding");
      }
    });
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              primaryColor.withAlpha(200),
              secondaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // App Logo
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radius3xl),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(50),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.email,
                                  size: 60,
                                  color: primaryColor,
                                ),
                              ),
                              
                              SizedBox(height: sp3xl),
                              
                              // App Name
                              Text(
                                "Email Manager",
                                style: TextStyle(
                                  fontSize: fsH1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Tagline
                              Text(
                                "Streamline Your Communication",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  color: Colors.white.withAlpha(220),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              
                              SizedBox(height: sp3xl),
                              
                              // Loading indicator
                              Container(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              // Bottom Content
              Padding(
                padding: EdgeInsets.all(sp2xl),
                child: Column(
                  children: [
                    // Version Info
                    Text(
                      "Version 1.0.0",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(180),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Copyright
                    Text(
                      "© 2024 Email Manager. All rights reserved.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(150),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Company Features
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFeatureIcon(Icons.security, "Secure"),
                        _buildFeatureIcon(Icons.speed, "Fast"),
                        _buildFeatureIcon(Icons.cloud, "Cloud"),
                        _buildFeatureIcon(Icons.mobile_friendly, "Mobile"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeatureIcon(IconData icon, String label) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withAlpha(180),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

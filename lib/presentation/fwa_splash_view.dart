import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaSplashView extends StatefulWidget {
  const FwaSplashView({super.key});

  @override
  State<FwaSplashView> createState() => _FwaSplashViewState();
}

class _FwaSplashViewState extends State<FwaSplashView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));
    
    _startAnimations();
    _navigateToNextScreen();
  }

  void _startAnimations() {
    _fadeController.forward();
    Future.delayed(Duration(milliseconds: 300), () {
      _scaleController.forward();
    });
  }

  void _navigateToNextScreen() {
    Future.delayed(Duration(seconds: 3), () {
      // navigateTo(FwaOnboardingView());
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor,
              primaryColor.withAlpha(200),
              secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              
              // Main Logo and Content
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _scaleAnimation,
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
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          size: 60,
                          color: primaryColor,
                        ),
                      ),
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: child,
                        );
                      },
                    ),
                    
                    SizedBox(height: spLg),
                    
                    AnimatedBuilder(
                      animation: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            "FitLife Pro",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Your Personal Fitness Journey",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withAlpha(230),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: child,
                        );
                      },
                    ),
                  ],
                ),
              ),
              
              // Bottom Features Preview
              Expanded(
                flex: 2,
                child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  child: Column(
                    children: [
                      SizedBox(height: spLg),
                      
                      // Feature Icons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildFeatureIcon(
                            Icons.directions_run,
                            "Workouts",
                          ),
                          _buildFeatureIcon(
                            Icons.restaurant_menu,
                            "Nutrition",
                          ),
                          _buildFeatureIcon(
                            Icons.analytics,
                            "Progress",
                          ),
                          _buildFeatureIcon(
                            Icons.group,
                            "Community",
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Loading Indicator
                      Container(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Text(
                        "Loading your fitness experience...",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(180),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value * 0.8,
                      child: child,
                    );
                  },
                ),
              ),
              
              // App Version
              Padding(
                padding: EdgeInsets.only(bottom: spMd),
                child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  child: Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(150),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value * 0.6,
                      child: child,
                    );
                  },
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
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(radiusSm),
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
            color: Colors.white.withAlpha(200),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

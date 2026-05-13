import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:async';

class GrlLoading6View extends StatefulWidget {
  @override
  State<GrlLoading6View> createState() => _GrlLoading6ViewState();
}

class _GrlLoading6ViewState extends State<GrlLoading6View>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  bool isLoading = true;
  int currentSlide = 0;
  String loadingMessage = "Initializing workspace...";

  List<Map<String, dynamic>> onboardingSlides = [
    {
      "title": "Welcome to FinanceTracker",
      "subtitle": "Your personal finance companion",
      "icon": Icons.account_balance_wallet,
      "color": Colors.green,
      "message": "Setting up your account...",
    },
    {
      "title": "Smart Budgeting",
      "subtitle": "AI-powered budget recommendations",
      "icon": Icons.trending_up,
      "color": Colors.blue,
      "message": "Loading financial insights...",
    },
    {
      "title": "Expense Tracking",
      "subtitle": "Track every penny with ease",
      "icon": Icons.receipt_long,
      "color": Colors.orange,
      "message": "Preparing expense categories...",
    },
    {
      "title": "Investment Analysis",
      "subtitle": "Smart investment portfolio tracking",
      "icon": Icons.show_chart,
      "color": Colors.purple,
      "message": "Connecting to market data...",
    },
    {
      "title": "Ready to Go!",
      "subtitle": "Your financial journey starts now",
      "icon": Icons.rocket_launch,
      "color": Colors.teal,
      "message": "All set! Let's begin!",
    },
  ];

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    
    _startSlideShow();
  }

  void _startSlideShow() async {
    for (int i = 0; i < onboardingSlides.length; i++) {
      if (!mounted) return;
      
      _fadeController.forward();
      currentSlide = i;
      loadingMessage = onboardingSlides[i]["message"];
      setState(() {});
      
      _slideController.forward();
      
      if (i == onboardingSlides.length - 1) {
        await Future.delayed(Duration(milliseconds: 2000));
        isLoading = false;
        setState(() {});
      } else {
        await Future.delayed(Duration(milliseconds: 3000));
        await _fadeController.reverse();
        _slideController.reset();
      }
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
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
              onboardingSlides[currentSlide]["color"].withAlpha(50),
              onboardingSlides[currentSlide]["color"].withAlpha(100),
              onboardingSlides[currentSlide]["color"].withAlpha(150),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Progress Bar
              Container(
                margin: EdgeInsets.all(spMd),
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: AnimatedBuilder(
                  animation: _slideController,
                  builder: (context, child) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 
                            ((currentSlide + _slideController.value) / onboardingSlides.length),
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Main Content
              Expanded(
                child: AnimatedBuilder(
                  animation: _fadeController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeController.value,
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - _fadeController.value)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Main Icon
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: onboardingSlides[currentSlide]["color"].withAlpha(80),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: AnimatedBuilder(
                                animation: _slideController,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: 0.8 + (_slideController.value * 0.2),
                                    child: Icon(
                                      onboardingSlides[currentSlide]["icon"],
                                      size: 90,
                                      color: onboardingSlides[currentSlide]["color"],
                                    ),
                                  );
                                },
                              ),
                            ),
                            
                            SizedBox(height: spXl),
                            
                            // Title and Subtitle
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: spLg),
                              child: Column(
                                children: [
                                  Text(
                                    onboardingSlides[currentSlide]["title"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: fsH2,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    onboardingSlides[currentSlide]["subtitle"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: spXl),
                            
                            // Loading Status
                            if (isLoading) ...[
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spLg,
                                  vertical: spMd,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: spLg),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: Border.all(
                                    color: Colors.white.withAlpha(50),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: spMd),
                                    Text(
                                      loadingMessage,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXl,
                                  vertical: spMd,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  boxShadow: [shadowXl],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 28,
                                    ),
                                    SizedBox(width: spMd),
                                    Text(
                                      "Welcome to FinanceTracker!",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: onboardingSlides[currentSlide]["color"],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Bottom Section
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    // Slide Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onboardingSlides.length, (index) {
                        bool isActive = index == currentSlide;
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          width: isActive ? 32 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isActive ? Colors.white : Colors.white.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                        );
                      }),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // App Features
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildQuickFeature(
                            Icons.security,
                            "Secure",
                            "Bank-level encryption",
                          ),
                          _buildQuickFeature(
                            Icons.speed,
                            "Fast",
                            "Lightning quick sync",
                          ),
                          _buildQuickFeature(
                            Icons.devices,
                            "Multi-device",
                            "Access anywhere",
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Version Info
                    Text(
                      "Version 2.1.0 • Built with ❤️",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white60,
                      ),
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

  Widget _buildQuickFeature(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

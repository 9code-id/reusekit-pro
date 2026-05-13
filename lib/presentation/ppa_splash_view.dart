import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSplashView extends StatefulWidget {
  const PpaSplashView({super.key});

  @override
  State<PpaSplashView> createState() => _PpaSplashViewState();
}

class _PpaSplashViewState extends State<PpaSplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  
  bool isLoading = true;
  String loadingText = "Initializing...";
  double loadingProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startLoadingSequence();
  }

  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _textAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    _logoController.forward();
    Future.delayed(Duration(milliseconds: 500), () {
      _textController.forward();
    });
  }

  void _startLoadingSequence() async {
    // Simulate app initialization steps
    await _loadStep("Checking camera permissions...", 0.2);
    await _loadStep("Loading filters and effects...", 0.4);
    await _loadStep("Preparing gallery...", 0.6);
    await _loadStep("Initializing pro features...", 0.8);
    await _loadStep("Ready to capture!", 1.0);
    
    await Future.delayed(Duration(milliseconds: 500));
    
    // Navigate to next screen
    _navigateToNext();
  }

  Future<void> _loadStep(String message, double progress) async {
    setState(() {
      loadingText = message;
      loadingProgress = progress;
    });
    await Future.delayed(Duration(milliseconds: 800));
  }

  void _navigateToNext() {
    // Check if user is first time or returning user
    // navigateTo OnboardingView or HomeView
    ss("Navigating to main app");
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
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
              primaryColor.withAlpha(200),
              secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App Logo
                      AnimatedBuilder(
                        animation: _logoAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _logoAnimation.value,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(50),
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 60,
                                color: primaryColor,
                              ),
                            ),
                          );
                        },
                      ),
                      
                      SizedBox(height: spLg),
                      
                      // App Name
                      AnimatedBuilder(
                        animation: _textAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _textAnimation.value,
                            child: Column(
                              children: [
                                Text(
                                  "PhotoPro",
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Professional Photography App",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withAlpha(200),
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Features Preview
                      AnimatedBuilder(
                        animation: _textAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _textAnimation.value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildFeatureIcon(Icons.camera, "Capture"),
                                _buildFeatureIcon(Icons.edit, "Edit"),
                                _buildFeatureIcon(Icons.filter, "Filters"),
                                _buildFeatureIcon(Icons.share, "Share"),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                
                // Loading Section
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Text(
                            loadingText,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Progress Bar
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: loadingProgress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Version Info
                    Text(
                      "Version 2.1.0 • Professional Edition",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(150),
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Copyright
                    Text(
                      "© 2024 PhotoPro Studios. All rights reserved.",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withAlpha(100),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            shape: BoxShape.circle,
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

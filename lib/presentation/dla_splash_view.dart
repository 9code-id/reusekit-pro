import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaSplashView extends StatefulWidget {
  const DlaSplashView({super.key});

  @override
  State<DlaSplashView> createState() => _DlaSplashViewState();
}

class _DlaSplashViewState extends State<DlaSplashView> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  double loadingProgress = 0.0;
  String loadingText = "Initializing...";
  
  List<Map<String, dynamic>> loadingSteps = [
    {"text": "Initializing application...", "duration": 800},
    {"text": "Loading configuration...", "duration": 600},
    {"text": "Connecting to services...", "duration": 900},
    {"text": "Verifying authentication...", "duration": 700},
    {"text": "Preparing workspace...", "duration": 500},
    {"text": "Almost ready...", "duration": 400},
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startLoadingSequence();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 2000),
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

    _fadeController.forward();
    _scaleController.forward();
  }

  void _startLoadingSequence() async {
    double progressStep = 1.0 / loadingSteps.length;
    
    for (int i = 0; i < loadingSteps.length; i++) {
      final step = loadingSteps[i];
      
      if (mounted) {
        setState(() {
          loadingText = step["text"];
          loadingProgress = (i + 1) * progressStep;
        });
      }
      
      await Future.delayed(Duration(milliseconds: step["duration"]));
    }
    
    // Complete loading and navigate
    if (mounted) {
      setState(() {
        loadingProgress = 1.0;
        loadingText = "Welcome!";
      });
      
      await Future.delayed(Duration(milliseconds: 500));
      //navigateTo ( DlaOnboardingView() );
    }
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              primaryColor.withAlpha(180),
              primaryColor.withAlpha(120),
            ],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: _buildContent(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(),
        ),
        Expanded(
          flex: 3,
          child: _buildLogo(),
        ),
        Expanded(
          flex: 2,
          child: _buildLoadingSection(),
        ),
        Expanded(
          flex: 1,
          child: _buildFooter(),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: spLg,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.auto_awesome,
                  size: 60,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spXs,
                children: [
                  Text(
                    "DeepLearning Analytics",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "Intelligent Data Insights Platform",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: spLg,
      children: [
        Container(
          width: 280,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: Colors.white.withAlpha(30),
              width: 1,
            ),
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loadingText,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${(loadingProgress * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: loadingProgress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusXs),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withAlpha(100),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildLoadingDots(),
      ],
    );
  }

  Widget _buildLoadingDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: spXs,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 600),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(
              (loadingProgress * 255 * (index + 1) / 3).toInt().clamp(30, 255),
            ),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildFooter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: spSm,
      children: [
        _buildFeatureHighlights(),
        Spacer(),
        _buildVersionInfo(),
      ],
    );
  }

  Widget _buildFeatureHighlights() {
    final features = [
      {"icon": Icons.analytics, "text": "Advanced Analytics"},
      {"icon": Icons.speed, "text": "Real-time Processing"},
      {"icon": Icons.security, "text": "Enterprise Security"},
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spLg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: features.map((feature) {
          return Column(
            spacing: spXs,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(20),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Icon(
                  feature["icon"] as IconData,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              Text(
                "${feature["text"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withAlpha(180),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: spXs,
            children: [
              Icon(
                Icons.copyright,
                color: Colors.white.withAlpha(120),
                size: 12,
              ),
              Text(
                "2024 DeepLearning Analytics Inc.",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withAlpha(120),
                ),
              ),
            ],
          ),
          Text(
            "Version 2.1.0 (Build 20240619)",
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withAlpha(100),
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

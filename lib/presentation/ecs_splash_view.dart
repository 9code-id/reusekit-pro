import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsSplashView extends StatefulWidget {
  const EcsSplashView({super.key});

  @override
  State<EcsSplashView> createState() => _EcsSplashViewState();
}

class _EcsSplashViewState extends State<EcsSplashView> 
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _progressController;
  
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _progressAnimation;
  
  bool showProgress = false;
  double loadingProgress = 0.0;
  String loadingText = "Initializing...";
  
  List<String> loadingSteps = [
    "Connecting to servers...",
    "Loading user preferences...",
    "Syncing data...",
    "Preparing interface...",
    "Almost ready...",
  ];
  
  int currentStepIndex = 0;  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    // Logo animation controller
    _logoController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    
    // Text animation controller
    _textController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Progress animation controller
    _progressController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    
    // Logo animations
    _logoScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));
    
    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Interval(0.0, 0.6, curve: Curves.easeIn),
    ));
    
    // Text fade animation
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));
    
    // Progress animation
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
    
    // Add listeners
    _progressController.addListener(() {
      loadingProgress = _progressAnimation.value;
      setState(() {});
      
      // Update loading text based on progress
      double stepProgress = _progressAnimation.value * loadingSteps.length;
      int newStepIndex = stepProgress.floor().clamp(0, loadingSteps.length - 1);
      
      if (newStepIndex != currentStepIndex && newStepIndex < loadingSteps.length) {
        currentStepIndex = newStepIndex;
        loadingText = loadingSteps[currentStepIndex];
        setState(() {});
      }
    });
  }

  void _startSplashSequence() async {
    // Start logo animation
    await _logoController.forward();
    
    // Wait a bit then show text
    await Future.delayed(Duration(milliseconds: 500));
    await _textController.forward();
    
    // Wait a bit then show progress
    await Future.delayed(Duration(milliseconds: 800));
    showProgress = true;
    setState(() {});
    
    // Start progress animation
    await _progressController.forward();
    
    // Complete splash and navigate
    await Future.delayed(Duration(milliseconds: 500));
    _completeSplash();
  }
  void _completeSplash() {
    // Navigate to main app
    //navigateTo(MainApp());
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _progressController.dispose();
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(25),
              Colors.white,
              primaryColor.withAlpha(50),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: spLg,
                    children: [
                      _buildLogoSection(),
                      _buildBrandingSection(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: spMd,
                  children: [
                    if (showProgress) _buildProgressSection(),
                    _buildFooterSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScaleAnimation.value,
          child: Opacity(
            opacity: _logoFadeAnimation.value,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusXl),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withAlpha(50),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Icons.eco,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBrandingSection() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return Opacity(
          opacity: _textFadeAnimation.value,
          child: Column(
            spacing: spSm,
            children: [
              Text(
                "EcoSystem",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                "Smart Environmental Solutions",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                width: 60,
                height: 3,
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressSection() {
    return AnimatedOpacity(
      opacity: showProgress ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: spXl),
        child: Column(
          spacing: spSm,
          children: [
            Text(
              loadingText,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: MediaQuery.of(context).size.width * 0.7 * loadingProgress,
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, successColor],
                    ),
                    borderRadius: BorderRadius.circular(radiusXs),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withAlpha(50),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              "${(loadingProgress * 100).toInt()}%",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterSection() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFeatureHighlight(Icons.eco, "Eco-Friendly"),
            SizedBox(width: spMd),
            _buildFeatureHighlight(Icons.analytics, "Smart Analytics"),
            SizedBox(width: spMd),
            _buildFeatureHighlight(Icons.security, "Secure"),
          ],
        ),
        SizedBox(height: spMd),
        Text(
          "Version 2.1.0",
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "© 2024 EcoSystem Solutions",
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureHighlight(IconData icon, String label) {
    return Column(
      spacing: spXs,
      children: [
        Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            icon,
            size: 16,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

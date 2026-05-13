import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSplashView extends StatefulWidget {
  const NmaSplashView({Key? key}) : super(key: key);

  @override
  State<NmaSplashView> createState() => _NmaSplashViewState();
}

class _NmaSplashViewState extends State<NmaSplashView> {
  bool loading = true;
  String loadingText = "Initializing...";
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoadingSequence();
  }

  Future<void> _startLoadingSequence() async {
    // Loading sequence simulation
    await _updateProgress("Loading news sources...", 0.2);
    await _updateProgress("Connecting to servers...", 0.4);
    await _updateProgress("Syncing latest articles...", 0.6);
    await _updateProgress("Personalizing content...", 0.8);
    await _updateProgress("Ready to read!", 1.0);
    
    await Future.delayed(Duration(milliseconds: 500));
    
    loading = false;
    setState(() {});
    
    // Navigate to onboarding or main app
    await Future.delayed(Duration(milliseconds: 800));
    // ss('Next page'));
  }

  Future<void> _updateProgress(String text, double newProgress) async {
    setState(() {
      loadingText = text;
      progress = newProgress;
    });
    await Future.delayed(Duration(milliseconds: 800));
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
              primaryColor.withAlpha(200),
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
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: spLg,
      children: [
        // App Icon/Logo
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
            Icons.newspaper,
            size: 60,
            color: primaryColor,
          ),
        ),
        
        // App Name
        Column(
          spacing: spSm,
          children: [
            Text(
              "NewsMax",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              "Stay Informed, Stay Ahead",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withAlpha(200),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spXl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: spLg,
        children: [
          if (loading) ...[
            // Loading Progress
            Column(
              spacing: spMd,
              children: [
                // Progress Bar
                Container(
                  width: double.infinity,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
                
                // Progress Text
                Text(
                  loadingText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(220),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                // Progress Percentage
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(180),
                  ),
                ),
              ],
            ),
            
            // Loading Animation
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(top: spMd),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ] else ...[
            // Success State
            Column(
              spacing: spMd,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: successColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Welcome to NewsMax!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Your personalized news experience awaits",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: spMd,
      children: [
        // Features Preview
        if (!loading)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spXl),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureIcon(Icons.flash_on, "Breaking"),
                _buildFeatureIcon(Icons.trending_up, "Trending"),
                _buildFeatureIcon(Icons.person, "Personal"),
                _buildFeatureIcon(Icons.offline_pin, "Offline"),
              ],
            ),
          ),
        
        // Copyright
        Padding(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spXs,
            children: [
              Text(
                "Powered by AI • Real-time Updates",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withAlpha(160),
                ),
              ),
              Text(
                "© 2025 NewsMax. All rights reserved.",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withAlpha(120),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      spacing: spXs,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withAlpha(180),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

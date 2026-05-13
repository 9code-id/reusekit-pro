import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaSplashView extends StatefulWidget {
  const RmaSplashView({super.key});

  @override
  State<RmaSplashView> createState() => _RmaSplashViewState();
}

class _RmaSplashViewState extends State<RmaSplashView> {
  bool loading = true;
  String loadingText = "Initializing...";

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Simulate app initialization process
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      loadingText = "Loading user preferences...";
    });
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      loadingText = "Connecting to servers...";
    });
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      loadingText = "Setting up restaurant management...";
    });
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      loadingText = "Almost ready...";
    });
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      loading = false;
    });
    
    // Navigate to onboarding or main app
    //navigateTo('RmaOnboardingView')
  }

  Widget _buildLogo() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [shadowLg],
      ),
      child: Icon(
        Icons.restaurant,
        size: 80,
        color: primaryColor,
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      spacing: spSm,
      children: [
        Text(
          "RestaurantManager",
          style: TextStyle(
            fontSize: fsH1,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          "Professional Restaurant Management Solution",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 3,
          ),
        ),
        Text(
          loadingText,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withAlpha(180),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureHighlights() {
    final features = [
      {
        "icon": Icons.inventory,
        "title": "Inventory Management",
        "description": "Track stock levels and automate ordering"
      },
      {
        "icon": Icons.people,
        "title": "Staff Management",
        "description": "Manage schedules and performance"
      },
      {
        "icon": Icons.analytics,
        "title": "Sales Analytics",
        "description": "Detailed insights and reporting"
      },
      {
        "icon": Icons.restaurant_menu,
        "title": "Menu Management",
        "description": "Easy menu updates and pricing"
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Powerful Features",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: features.map((feature) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: Colors.white.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    feature["icon"] as IconData,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    "${feature["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${feature["description"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            "Version 2.1.0",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(150),
            ),
          ),
          Text(
            "Built for professional restaurants",
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withAlpha(120),
            ),
          ),
        ],
      ),
    );
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
              secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: spLg,
                    children: [
                      _buildLogo(),
                      _buildWelcomeText(),
                    ],
                  ),
                ),
              ),
              if (loading) ...[
                _buildLoadingIndicator(),
                SizedBox(height: spXl),
              ] else ...[
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: _buildFeatureHighlights(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  child: QButton(
                    label: "Get Started",
                    size: bs.md,
                    color: Colors.white,
                    onPressed: () {
                      //navigateTo('RmaOnboardingView')
                    },
                  ),
                ),
              ],
              _buildVersionInfo(),
            ],
          ),
        ),
      ),
    );
  }
}

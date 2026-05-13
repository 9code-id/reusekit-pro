import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaSplashView extends StatefulWidget {
  const BfaSplashView({super.key});

  @override
  State<BfaSplashView> createState() => _BfaSplashViewState();
}

class _BfaSplashViewState extends State<BfaSplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 3));
    // Navigate to onboarding or login
    // navigateTo(BfaOnboardingView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusXl),
                boxShadow: [shadowLg],
              ),
              child: Icon(
                Icons.account_balance,
                size: 60,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // App Name
            Text(
              "BankPro",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Tagline
            Text(
              "Your Financial Partner",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withAlpha(200),
                fontWeight: FontWeight.w500,
              ),
            ),
            
            SizedBox(height: sp4xl),
            
            // Loading Animation
            Container(
              width: 200,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white.withAlpha(100),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            
            SizedBox(height: spLg),
            
            Text(
              "Initializing secure connection...",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(180),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

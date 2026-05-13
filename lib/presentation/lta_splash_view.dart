import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaSplashView extends StatefulWidget {
  const LtaSplashView({super.key});

  @override
  State<LtaSplashView> createState() => _LtaSplashViewState();
}

class _LtaSplashViewState extends State<LtaSplashView> {
  @override
  void initState() {
    super.initState();
    _initSplash();
  }

  Future<void> _initSplash() async {
    await Future.delayed(Duration(seconds: 3));
    // ss('Next page'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Section
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusXl),
                boxShadow: [shadowLg],
              ),
              child: Icon(
                Icons.local_shipping,
                size: 60,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spLg),
            
            // App Name
            Text(
              "LogiTrans",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Tagline
            Text(
              "Smart Logistics Solutions",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withAlpha(200),
                letterSpacing: 1.2,
              ),
            ),
            
            SizedBox(height: spXl * 2),
            
            // Loading Animation
            Container(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Loading Text
            Text(
              "Initializing...",
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

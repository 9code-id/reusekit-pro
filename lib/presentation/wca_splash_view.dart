import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaSplashView extends StatefulWidget {
  const WcaSplashView({super.key});

  @override
  State<WcaSplashView> createState() => _WcaSplashViewState();
}

class _WcaSplashViewState extends State<WcaSplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 3));
    // Navigate to onboarding
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
              Color(0xFF87CEEB),
              Color(0xFF4682B4),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusXl),
                  boxShadow: [shadowLg],
                ),
                child: Icon(
                  Icons.wb_sunny,
                  size: 60,
                  color: Color(0xFFFFB74D),
                ),
              ),
              SizedBox(height: spLg),
              Text(
                "WeatherCast",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Your Personal Weather Assistant",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(200),
                ),
              ),
              SizedBox(height: spXl),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

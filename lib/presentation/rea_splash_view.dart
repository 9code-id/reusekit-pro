import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaSplashView extends StatefulWidget {
  const ReaSplashView({super.key});

  @override
  State<ReaSplashView> createState() => _ReaSplashViewState();
}

class _ReaSplashViewState extends State<ReaSplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  Future<void> _navigateToOnboarding() async {
    await Future.delayed(Duration(seconds: 3));
    
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
            Icon(
              Icons.home_work,
              size: 120,
              color: Colors.white,
            ),
            SizedBox(height: spLg),
            Text(
              "RealEstate Pro",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Find Your Dream Property",
              style: TextStyle(
                fontSize: fsH6,
                color: Colors.white.withAlpha(200),
              ),
            ),
            SizedBox(height: spXl),
            Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

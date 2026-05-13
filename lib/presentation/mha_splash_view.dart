import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaSplashView extends StatefulWidget {
  const MhaSplashView({super.key});

  @override
  State<MhaSplashView> createState() => _MhaSplashViewState();
}

class _MhaSplashViewState extends State<MhaSplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() async {
    await Future.delayed(Duration(seconds: 3));
    // navigateTo(MhaOnboardingView());
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
              primaryColor,
              primaryColor.withAlpha(200),
            ],
          ),
        ),
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
                Icons.medical_services,
                size: 60,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "HealthCare+",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Your Complete Health Companion",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withAlpha(230),
              ),
            ),
            SizedBox(height: spXl),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.local_hospital,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.medication,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spXl),
            SizedBox(height: spXl),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
            SizedBox(height: spMd),
            Text(
              "Loading your health data...",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(200),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

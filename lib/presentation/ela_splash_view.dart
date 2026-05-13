import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaSplashView extends StatefulWidget {
  const ElaSplashView({super.key});

  @override
  State<ElaSplashView> createState() => _ElaSplashViewState();
}

class _ElaSplashViewState extends State<ElaSplashView> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  void _initApp() async {
    await Future.delayed(Duration(seconds: 3));
    // navigateTo(ElaOnboardingView())
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, primaryColor.withAlpha(180)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [shadowLg],
                    ),
                    child: Icon(
                      Icons.school,
                      size: 60,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Text(
                    "EduLearn",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Learning Management System",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spXl),
                  Container(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Text(
                    "Empowering Education Through Technology",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(150),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

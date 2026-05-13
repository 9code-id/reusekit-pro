import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaSplashView extends StatefulWidget {
  const CmaSplashView({super.key});

  @override
  State<CmaSplashView> createState() => _CmaSplashViewState();
}

class _CmaSplashViewState extends State<CmaSplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 3));
    // ss('Next page'));
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
                  Icons.people,
                  size: 60,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spLg),
              Text(
                "CRM Pro",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Customer Management Made Easy",
                style: TextStyle(
                  fontSize: fsH6,
                  color: Colors.white.withAlpha(200),
                ),
              ),
              SizedBox(height: spXl),
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(height: spLg),
              Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(180),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

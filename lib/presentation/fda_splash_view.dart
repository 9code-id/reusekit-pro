import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaSplashView extends StatefulWidget {
  const FdaSplashView({super.key});

  @override
  State<FdaSplashView> createState() => _FdaSplashViewState();
}

class _FdaSplashViewState extends State<FdaSplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 3));
    
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
                Icons.restaurant,
                size: 60,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "FoodExpress",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Fast & Fresh Delivery",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withAlpha(200),
              ),
            ),
            SizedBox(height: spXl),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}


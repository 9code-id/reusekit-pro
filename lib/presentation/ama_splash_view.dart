import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSplashView extends StatefulWidget {
  const AmaSplashView({super.key});

  @override
  State<AmaSplashView> createState() => _AmaSplashViewState();
}

class _AmaSplashViewState extends State<AmaSplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(Duration(seconds: 3));
    // ss('Next page'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: successColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowLg],
              ),
              child: Icon(
                Icons.agriculture,
                size: 60,
                color: successColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "AgroManager",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Smart Agriculture Management",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withAlpha(200),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: spXl),
            Container(
              width: 200,
              child: Column(
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Loading your farm data...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(180),
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

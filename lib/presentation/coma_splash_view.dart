import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaSplashView extends StatefulWidget {
  const ComaSplashView({super.key});

  @override
  State<ComaSplashView> createState() => _ComaSplashViewState();
}

class _ComaSplashViewState extends State<ComaSplashView> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    setState(() {});
    
    // Navigate to onboarding or login after splash
    // ss('Next page'));
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
              primaryColor.withAlpha(180),
              secondaryColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(30),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.medical_services,
                      size: 60,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Text(
                    "COMA",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                  Text(
                    "Medical Assistant",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withAlpha(200),
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spLg, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "Your AI-Powered Healthcare Companion",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading) ...[
                    Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Initializing COMA...",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(180),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ] else ...[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Ready to assist you!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 8,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(100),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(120),
                    ),
                  ),
                  Text(
                    "© 2024 COMA Medical Systems",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(120),
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

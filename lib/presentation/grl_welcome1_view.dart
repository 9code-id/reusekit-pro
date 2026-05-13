import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWelcome1View extends StatefulWidget {
  @override
  State<GrlWelcome1View> createState() => _GrlWelcome1ViewState();
}

class _GrlWelcome1ViewState extends State<GrlWelcome1View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: sp2xl),
            
            // Welcome Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.rocket_launch,
                size: 60,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Welcome Text
            Text(
              "Welcome to ReuseKit",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Your journey to amazing experiences starts here",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Feature Cards
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.speed,
                          color: successColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fast & Reliable",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Lightning fast performance with 99.9% uptime",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.security,
                          color: infoColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Secure & Private",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Your data is protected with enterprise-grade security",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.support_agent,
                          color: warningColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "24/7 Support",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Get help whenever you need it from our expert team",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Action Buttons
            QButton(
              label: "Get Started",
              size: bs.md,
              onPressed: () {
                // navigateTo('');
              },
            ),
            
            SizedBox(height: spSm),
            
            GestureDetector(
              onTap: () {
                // navigateTo('');
              },
              child: Text(
                "Already have an account? Sign In",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}

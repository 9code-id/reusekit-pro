import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsWelcomeView extends StatefulWidget {
  const BrsWelcomeView({super.key});

  @override
  State<BrsWelcomeView> createState() => _BrsWelcomeViewState();
}

class _BrsWelcomeViewState extends State<BrsWelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spMd),
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
        child: Column(
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
                      boxShadow: [shadowLg],
                    ),
                    child: Icon(
                      Icons.content_cut,
                      size: 60,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Text(
                    "BarberShop",
                    style: TextStyle(
                      fontSize: fsH1,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Premium Grooming Experience",
                    style: TextStyle(
                      fontSize: fsH6,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Book Your Appointment",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Choose from top-rated barbers in your area",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spLg),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Premium Services",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Hair cuts, beard styling, and grooming services",
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
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  QButton(
                    label: "Get Started",
                    size: bs.md,
                    color: Colors.white,
                    onPressed: () async {},
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.white.withAlpha(180),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
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

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaOnboardingView extends StatefulWidget {
  const WcaOnboardingView({super.key});

  @override
  State<WcaOnboardingView> createState() => _WcaOnboardingViewState();
}

class _WcaOnboardingViewState extends State<WcaOnboardingView> {
  int currentPage = 0;

  List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Real-Time Weather Updates",
      "subtitle": "Get accurate weather information for your location",
      "description": "Stay informed with live weather data including temperature, humidity, wind speed, and atmospheric pressure updated every minute.",
      "image": "https://picsum.photos/300/200?random=1&keyword=weather",
      "icon": Icons.cloud,
      "color": Colors.blue,
    },
    {
      "title": "Detailed Forecasts",
      "subtitle": "Plan ahead with hourly and daily predictions",
      "description": "Access comprehensive weather forecasts up to 14 days ahead with detailed hourly breakdowns and weather pattern analysis.",
      "image": "https://picsum.photos/300/200?random=2&keyword=forecast",
      "icon": Icons.schedule,
      "color": Colors.green,
    },
    {
      "title": "Weather Alerts",
      "subtitle": "Stay safe with timely weather warnings",
      "description": "Receive instant notifications about severe weather conditions, storms, and emergency weather alerts in your area.",
      "image": "https://picsum.photos/300/200?random=3&keyword=storm",
      "icon": Icons.warning,
      "color": Colors.orange,
    },
    {
      "title": "Multiple Locations",
      "subtitle": "Track weather anywhere in the world",
      "description": "Add multiple cities and locations to monitor weather conditions for your travels, family, and business needs.",
      "image": "https://picsum.photos/300/200?random=4&keyword=globe",
      "icon": Icons.public,
      "color": Colors.purple,
    },
    {
      "title": "Weather Maps",
      "subtitle": "Visualize weather patterns with interactive maps",
      "description": "Explore radar maps, satellite imagery, and precipitation patterns to understand weather movements and trends.",
      "image": "https://picsum.photos/300/200?random=5&keyword=map",
      "icon": Icons.map,
      "color": Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(20),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(onboardingData.length, (index) {
                        return Container(
                          margin: EdgeInsets.only(right: spXs),
                          width: currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage == index ? primaryColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        );
                      }),
                    ),
                    if (currentPage < onboardingData.length - 1)
                      GestureDetector(
                        onTap: () {
                          currentPage = onboardingData.length - 1;
                          setState(() {});
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        margin: EdgeInsets.symmetric(horizontal: spMd),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowLg],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${onboardingData[currentPage]["image"]}",
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: (onboardingData[currentPage]["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      onboardingData[currentPage]["icon"],
                                      size: 80,
                                      color: onboardingData[currentPage]["color"],
                                    ),
                                    SizedBox(height: spSm),
                                    Text(
                                      "${onboardingData[currentPage]["title"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: onboardingData[currentPage]["color"],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: spLg),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (onboardingData[currentPage]["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Icon(
                                onboardingData[currentPage]["icon"],
                                size: 40,
                                color: onboardingData[currentPage]["color"],
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${onboardingData[currentPage]["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${onboardingData[currentPage]["subtitle"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.w600,
                                color: onboardingData[currentPage]["color"],
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${onboardingData[currentPage]["description"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spLg),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: successColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Free to use with no hidden charges",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: successColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Accurate data from trusted sources",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: successColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Works offline with cached data",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spSm,
                  children: [
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: currentPage < onboardingData.length - 1 ? "Continue" : "Get Started",
                        onPressed: () {
                          if (currentPage < onboardingData.length - 1) {
                            currentPage++;
                            setState(() {});
                          } else {
                            ss("Welcome to Weather App!");
                          }
                        },
                      ),
                    ),
                    if (currentPage > 0)
                      GestureDetector(
                        onTap: () {
                          currentPage--;
                          setState(() {});
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          child: Text(
                            "Back",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

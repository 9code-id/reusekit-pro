import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaOnboardingView extends StatefulWidget {
  const ReaOnboardingView({super.key});

  @override
  State<ReaOnboardingView> createState() => _ReaOnboardingViewState();
}

class _ReaOnboardingViewState extends State<ReaOnboardingView> {
  int currentPage = 0;
  PageController pageController = PageController();

  List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Discover Properties",
      "description": "Browse thousands of verified properties from trusted sellers and agents",
      "icon": Icons.search,
      "color": primaryColor,
    },
    {
      "title": "Virtual Tours",
      "description": "Take immersive virtual tours and view detailed floor plans before visiting",
      "icon": Icons.view_in_ar,
      "color": successColor,
    },
    {
      "title": "Smart Investment",
      "description": "Get market insights, price trends, and investment analysis for better decisions",
      "icon": Icons.trending_up,
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 200,
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Container(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: onboardingData[currentPage]["color"],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              onboardingData[currentPage]["icon"],
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spLg),
                          Text(
                            "${onboardingData[currentPage]["title"]}",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: spMd),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: spLg),
                            child: Text(
                              "${onboardingData[currentPage]["description"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                color: disabledBoldColor,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spLg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onboardingData.length, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          width: currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage == index ? primaryColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                if (currentPage > 0)
                  QButton(
                    label: "Back",
                    size: bs.md,
                    color: disabledBoldColor,
                    onPressed: () {
                      if (currentPage > 0) {
                        currentPage--;
                        setState(() {});
                      }
                    },
                  ),
                if (currentPage > 0) SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: currentPage == onboardingData.length - 1 ? "Get Started" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentPage < onboardingData.length - 1) {
                        currentPage++;
                        setState(() {});
                      } else {
                        // --
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

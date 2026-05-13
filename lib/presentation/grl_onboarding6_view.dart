import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOnboarding6View extends StatefulWidget {
  const GrlOnboarding6View({super.key});

  @override
  State<GrlOnboarding6View> createState() => _GrlOnboarding6ViewState();
}

class _GrlOnboarding6ViewState extends State<GrlOnboarding6View> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Welcome to Innovation",
      "description": "Experience the future of technology with our cutting-edge platform designed for modern users.",
      "image": "https://picsum.photos/300/200?random=6&keyword=innovation",
      "color": primaryColor,
    },
    {
      "title": "Smart Solutions",
      "description": "Discover intelligent features that adapt to your needs and streamline your daily workflow.",
      "image": "https://picsum.photos/300/200?random=7&keyword=smart",
      "color": successColor,
    },
    {
      "title": "Global Connectivity",
      "description": "Connect with users worldwide and expand your network with our global platform.",
      "image": "https://picsum.photos/300/200?random=8&keyword=global",
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    onboardingData[currentPage]["color"].withAlpha(20),
                    Colors.white,
                  ],
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusXl),
                        boxShadow: [shadowLg],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXl),
                        child: Image.network(
                          "${onboardingData[currentPage]["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: sp2xl),
                    Text(
                      "${onboardingData[currentPage]["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH1,
                        fontWeight: FontWeight.bold,
                        color: onboardingData[currentPage]["color"],
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${onboardingData[currentPage]["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: sp2xl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onboardingData.length, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          width: index == currentPage ? 32 : 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: index == currentPage 
                                ? onboardingData[currentPage]["color"]
                                : disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
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
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: () {
                        if (currentPage > 0) {
                          currentPage--;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                if (currentPage > 0) SizedBox(width: spMd),
                Expanded(
                  flex: currentPage == 0 ? 1 : 1,
                  child: QButton(
                    label: currentPage == onboardingData.length - 1 
                        ? "Get Started" 
                        : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentPage < onboardingData.length - 1) {
                        currentPage++;
                        setState(() {});
                      } else {
                        //navigateTo('register')
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

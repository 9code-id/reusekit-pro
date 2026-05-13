import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaOnboardingView extends StatefulWidget {
  const SmaOnboardingView({super.key});

  @override
  State<SmaOnboardingView> createState() => _SmaOnboardingViewState();
}

class _SmaOnboardingViewState extends State<SmaOnboardingView> {
  int currentPage = 0;

  List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Connect with Friends",
      "description": "Stay connected with friends and family. Share your moments and discover what's happening in their lives.",
      "image": "https://picsum.photos/300/300?random=1&keyword=friends",
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "Share Your Story",
      "description": "Share photos, videos, and thoughts. Express yourself with posts, stories, and live updates.",
      "image": "https://picsum.photos/300/300?random=2&keyword=camera",
      "icon": Icons.camera_alt,
      "color": secondaryColor,
    },
    {
      "title": "Discover New Content",
      "description": "Explore trending topics, discover new interests, and connect with like-minded people around the world.",
      "image": "https://picsum.photos/300/300?random=3&keyword=explore",
      "icon": Icons.explore,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: spLg),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to login
                    // ss('Next page'));
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // Page Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusXl),
                      boxShadow: [shadowMd],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusXl),
                      child: Image.network(
                        "${onboardingData[currentPage]["image"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: spXl),

                  // Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: (onboardingData[currentPage]["color"] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      onboardingData[currentPage]["icon"] as IconData,
                      size: 40,
                      color: onboardingData[currentPage]["color"] as Color,
                    ),
                  ),
                  SizedBox(height: spLg),

                  // Title
                  Text(
                    "${onboardingData[currentPage]["title"]}",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spMd),

                  // Description
                  Text(
                    "${onboardingData[currentPage]["description"]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingData.length, (index) {
                return Container(
                  width: currentPage == index ? 24 : 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: currentPage == index 
                        ? primaryColor 
                        : primaryColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                );
              }),
            ),
            SizedBox(height: spXl),

            // Navigation Buttons
            Row(
              children: [
                if (currentPage > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      onPressed: () {
                        if (currentPage > 0) {
                          currentPage--;
                          setState(() {});
                        }
                      },
                    ),
                  )
                else
                  Spacer(),

                SizedBox(width: spMd),

                Expanded(
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
                        // Navigate to login
                        // ss('Next page'));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}

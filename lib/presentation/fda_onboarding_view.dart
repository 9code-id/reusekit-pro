import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaOnboardingView extends StatefulWidget {
  const FdaOnboardingView({super.key});

  @override
  State<FdaOnboardingView> createState() => _FdaOnboardingViewState();
}

class _FdaOnboardingViewState extends State<FdaOnboardingView> {
  int currentPage = 0;
  
  List<Map<String, dynamic>> onboardingData = [
    {
      "image": "https://picsum.photos/300/300?random=1&keyword=food",
      "title": "Discover Great Food",
      "description": "Find your favorite meals from the best restaurants in your area with just a few taps."
    },
    {
      "image": "https://picsum.photos/300/300?random=2&keyword=delivery",
      "title": "Fast Delivery",
      "description": "Get your food delivered hot and fresh to your doorstep in under 30 minutes."
    },
    {
      "image": "https://picsum.photos/300/300?random=3&keyword=payment",
      "title": "Easy Payment",
      "description": "Pay securely with multiple payment options including cards, wallets, and cash on delivery."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: spXl),
            
            // Onboarding Image
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${onboardingData[currentPage]["image"]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Title
            Text(
              "${onboardingData[currentPage]["title"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Description
            Text(
              "${onboardingData[currentPage]["description"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingData.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: spXs),
                  width: currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentPage == index ? primaryColor : disabledColor,
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
                      color: disabledBoldColor,
                      onPressed: () {
                        currentPage--;
                        setState(() {});
                      },
                    ),
                  ),
                
                if (currentPage > 0) SizedBox(width: spMd),
                
                Expanded(
                  child: QButton(
                    label: currentPage == onboardingData.length - 1 ? "Get Started" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentPage == onboardingData.length - 1) {
                        // Go to location permission
                        // --
                      } else {
                        currentPage++;
                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Skip Button
            if (currentPage < onboardingData.length - 1)
              GestureDetector(
                onTap: () {
                  // --
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
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsOnboardingView extends StatefulWidget {
  const EcsOnboardingView({super.key});

  @override
  State<EcsOnboardingView> createState() => _EcsOnboardingViewState();
}

class _EcsOnboardingViewState extends State<EcsOnboardingView> {
  int currentPage = 0;
  
  final List<Map<String, dynamic>> onboardingData = [
    {
      "icon": Icons.shopping_cart,
      "title": "Shop with Ease",
      "description": "Browse thousands of products from top brands and find exactly what you're looking for.",
      "color": Colors.blue,
    },
    {
      "icon": Icons.local_shipping,
      "title": "Fast Delivery",
      "description": "Get your orders delivered quickly with our reliable shipping partners across the country.",
      "color": Colors.green,
    },
    {
      "icon": Icons.payment,
      "title": "Secure Payment",
      "description": "Shop with confidence using our secure payment gateway and multiple payment options.",
      "color": Colors.orange,
    },
    {
      "icon": Icons.support_agent,
      "title": "24/7 Support",
      "description": "Our customer support team is always ready to help you with any questions or concerns.",
      "color": Colors.purple,
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
            Container(
              height: 400,
              child: QHorizontalScroll(
                children: List.generate(onboardingData.length, (index) {
                  final item = onboardingData[index];
                  return Container(
                    width: MediaQuery.of(context).size.width - (spMd * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: (item["color"] as Color).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: (item["color"] as Color).withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            item["icon"] as IconData,
                            size: 60,
                            color: item["color"] as Color,
                          ),
                        ),
                        SizedBox(height: spLg),
                        Text(
                          "${item["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${item["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: spLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingData.length, (index) {
                return Container(
                  width: currentPage == index ? 24 : 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: currentPage == index ? primaryColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                );
              }),
            ),
            SizedBox(height: spXl),
            Row(
              children: [
                if (currentPage > 0) ...[
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
                  SizedBox(width: spMd),
                ],
                Expanded(
                  child: QButton(
                    label: currentPage == onboardingData.length - 1 ? "Get Started" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentPage < onboardingData.length - 1) {
                        currentPage++;
                        setState(() {});
                      } else {
                        // ss('Next page'));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            GestureDetector(
              onTap: () {
                // ss('Next page'));
              },
              child: Text(
                "Skip",
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
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
